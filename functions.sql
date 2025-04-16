use pcbuilder;

DELIMITER $$
CREATE FUNCTION `get_best_case_fan_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT cf.id,
            (
                -- Airflow score (up to 2 points)
                CASE
                    WHEN cf.airflow REGEXP '[0-9]' THEN
                        CASE
                            WHEN CAST(REGEXP_SUBSTR(cf.airflow, '[0-9.]+') AS DECIMAL(10,2)) > 70 THEN 2
                            WHEN CAST(REGEXP_SUBSTR(cf.airflow, '[0-9.]+') AS DECIMAL(10,2)) > 50 THEN 1
                            ELSE 0
                        END
                    ELSE 0
                END

                -- PWM bonus (1 point)
                + CASE
                    WHEN cf.pwm = 1 THEN 1
                    ELSE 0
                END
            ) AS score
        FROM case_fan cf
        WHERE cf.price <= budget
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- case table function
DELIMITER $$
CREATE FUNCTION `get_best_case_id`(motherboard_id INT, budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;
    DECLARE mobo_form_factor VARCHAR(50);
    DECLARE mobo_color VARCHAR(50);
    DECLARE mobo_price DECIMAL(10,2);
    
    -- Get motherboard details
    SELECT form_factor, color, price INTO mobo_form_factor, mobo_color, mobo_price
    FROM motherboard WHERE id = motherboard_id;
    
    -- Find best matching case with more balanced scoring
    SELECT c.id INTO best_id
    FROM case_table c
    WHERE c.price IS NOT NULL AND c.price <= budget
    ORDER BY
        (
            -- 1. Form factor compatibility (absolute requirement)
            CASE
                WHEN mobo_form_factor LIKE '%ATX%' AND c.type LIKE '%ATX%' THEN 30
                WHEN mobo_form_factor LIKE '%Micro%' AND c.type LIKE '%Micro%' THEN 30
                WHEN mobo_form_factor LIKE '%Mini%' AND c.type LIKE '%Mini%' THEN 30
                ELSE -1000 -- Disqualify incompatible cases
            END
            +
            
            -- 2. Price-to-feature ratio (more dynamic)
            CASE
                -- Premium motherboards deserve better cases
                WHEN mobo_price > 200 THEN 
                    (c.external_volume * 0.5) + 
                    (CASE WHEN c.side_panel LIKE '%Tempered Glass%' THEN 15 ELSE 0 END) +
                    (c.internal_35_bays * 2)
                
                -- Mid-range motherboards
                WHEN mobo_price > 100 THEN 
                    (budget - c.price) * 0.03 +
                    (CASE WHEN c.side_panel LIKE '%Tempered Glass%' THEN 10 ELSE 0 END) +
                    (c.internal_35_bays * 1.5)
                
                -- Budget motherboards
                ELSE 
                    (budget - c.price) * 0.05 +
                    (CASE WHEN c.side_panel LIKE '%Glass%' THEN 5 ELSE 0 END)
            END
            
            +
            
            -- 4. Size appropriateness (match motherboard class)
            CASE
                WHEN mobo_price > 200 AND c.external_volume > 50 THEN 5
                WHEN mobo_price > 200 AND c.external_volume > 40 THEN 3
                WHEN mobo_price <= 100 AND c.external_volume < 40 THEN 5
                ELSE 2
            END
            
            +
            
            CASE
				WHEN c.internal_35_bays >= 8 THEN 4
                WHEN c.internal_35_bays >= 4 THEN 3
                WHEN c.internal_35_bays >= 2 THEN 2
                WHEN c.internal_35_bays = 1 THEN 1
                ELSE 0
            END
        ) DESC,
        -- Secondary sort to maintain consistency when scores are equal
        CASE 
            WHEN mobo_price > 200 THEN c.external_volume
            ELSE c.price
        END ASC
    LIMIT 1;
    
    RETURN best_id;
END$$
DELIMITER ;


--cpu cooler function
DELIMITER $$
CREATE FUNCTION `get_best_cpu_cooler_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT id,
            (
                -- Size-based scoring
                CASE
                    WHEN size IS NOT NULL AND (
                        LOWER(size) LIKE '%240%' OR 
                        LOWER(size) LIKE '%280%' OR 
                        LOWER(size) LIKE '%360%' OR 
                        LOWER(size) LIKE '%water%'
                    ) THEN 3
                    WHEN size IS NOT NULL AND (
                        LOWER(size) LIKE '%tower%' OR 
                        CAST(REPLACE(REPLACE(REPLACE(size, 'mm', ''), ' ', ''), 'x', '') AS UNSIGNED) > 120
                    ) THEN 2
                    WHEN size IS NOT NULL THEN 1
                    ELSE 0
                END
                +
                -- Noise-level scoring
                CASE
                    WHEN noise_level IS NOT NULL AND 
                         (noise_level LIKE '%silent%' OR noise_level LIKE '%quiet%') THEN 1
                    WHEN noise_level IS NOT NULL THEN
                        CASE
                            WHEN CAST(SUBSTRING_INDEX(noise_level, ' ', 1) AS DECIMAL) < 25 THEN 2
                            WHEN CAST(SUBSTRING_INDEX(noise_level, ' ', 1) AS DECIMAL) < 30 THEN 1
                            ELSE 0
                        END
                    ELSE 0
                END
            ) AS score
        FROM cpu_cooler
        WHERE price <= budget AND price IS NOT NULL
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- cpu function
DELIMITER $$
CREATE FUNCTION `get_best_cpu_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_cpu_id INT;

    SELECT c.id INTO best_cpu_id
    FROM cpu c
    WHERE c.price <= budget
    ORDER BY 
        (
            -- 1. Core Count Score (max 12)
            CASE 
                WHEN c.core_count >= 64 THEN 12
                WHEN c.core_count >= 32 THEN 10
                WHEN c.core_count >= 16 THEN 8
                WHEN c.core_count >= 8 THEN 6
                WHEN c.core_count >= 4 THEN 4
                ELSE 2
            END

            +

            -- 2. Clock Speed Score (Boost preferred, fallback to core)
            CASE 
                WHEN c.boost_clock IS NOT NULL THEN 
                    LEAST(GREATEST((c.boost_clock - 2.0) * 3.33, 0), 10)
                WHEN c.core_clock IS NOT NULL THEN 
                    LEAST(GREATEST((c.core_clock - 1.5) * 3.33, 0), 8)
                ELSE 0
            END

            +

            -- 3. SMT Bonus (3 points)
            CASE WHEN c.smt = 1 THEN 3 ELSE 0 END

            +

            -- 4. Integrated Graphics Bonus (2 points)
            CASE 
                WHEN c.graphics IS NOT NULL AND TRIM(c.graphics) <> '' AND LOWER(TRIM(c.graphics)) <> 'none' THEN 2
                ELSE 0
            END

            +

            -- 5. TDP Efficiency (max 3 points)
            CASE 
                WHEN c.tdp IS NOT NULL AND c.core_count IS NOT NULL AND c.core_count > 0 THEN
                    CASE 
                        WHEN (c.tdp / c.core_count) < 10 THEN 3
                        WHEN (c.tdp / c.core_count) < 15 THEN 2
                        WHEN (c.tdp / c.core_count) < 20 THEN 1
                        ELSE 0
                    END
                ELSE 0
            END
        ) DESC,
        c.price ASC
    LIMIT 1;

    RETURN best_cpu_id;
END$$
DELIMITER ;

-- external drive
DELIMITER $$
CREATE FUNCTION `get_best_external_drive_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT id,
            (
                CASE 
                    WHEN type = 'SSD' THEN 2 
                    ELSE 0 
                END
            ) AS score
        FROM external_hard_drive
        WHERE price <= budget AND price IS NOT NULL
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- fan controller
DELIMITER $$
CREATE FUNCTION `get_best_fan_controller_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT fc.id,
            (
                -- Base score for having a fan controller (2 points)
                2

                -- PWM support (1 point)
                + CASE 
                    WHEN fc.pwm = 1 THEN 1
                    ELSE 0
                  END

                -- Channel count ≥ 6 (1 point)
                + CASE
                    WHEN fc.channels >= 6 THEN 1
                    ELSE 0
                  END
            ) AS score
        FROM fan_controller fc
        WHERE fc.price <= budget
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;


-- internal drive
DELIMITER $$
CREATE FUNCTION `get_best_internal_drive_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT DEFAULT NULL;

    -- Select the best internal hard drive based on the budget and scoring
    SELECT id INTO best_id
    FROM (
        SELECT id,
            (
                CASE 
                    WHEN type = 'SSD' THEN 5 
                    ELSE 2 
                END
                + CASE 
                    WHEN type = 'SSD' AND LOWER(interface) LIKE '%nvme%' THEN 3
                    WHEN type = 'SSD' AND LOWER(interface) LIKE '%sata%' THEN 2
                    WHEN type = 'SSD' AND interface IS NOT NULL THEN 1
                    ELSE 0
                END
                + CASE 
                    WHEN type = 'SSD' AND capacity IS NOT NULL THEN LEAST(FLOOR(capacity / 500), 2)
                    ELSE 0
                END
                + CASE
                    WHEN price_per_gb IS NOT NULL THEN LEAST(FLOOR(price_per_gb / 0.1), 2)  -- Example of considering price per GB
                    ELSE 0
                END
            ) AS score
        FROM internal_hard_drive
        WHERE price <= budget AND price IS NOT NULL
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    -- Check if a best id was found
    IF best_id IS NULL THEN
        -- Handle the case where no internal drive matches the criteria
        RETURN -1; -- Return a default error value indicating no valid drive was found
    END IF;

    -- Return the best id
    RETURN best_id;
END$$
DELIMITER ;


-- memory function
DELIMITER $$
CREATE FUNCTION `get_best_memory_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT m.id,
            (
                -- Speed score (up to 8)
                COALESCE(LEAST(CAST(REPLACE(m.speed, ',', '') AS UNSIGNED) DIV 400, 8), 0)
                
                -- Total RAM from modules (up to 7)
                + COALESCE(
                    LEAST(
                        CAST(SUBSTRING_INDEX(m.modules, 'x', 1) AS UNSIGNED) * 
                        CAST(SUBSTRING_INDEX(m.modules, 'x', -1) AS UNSIGNED) DIV 4,
                        7
                    ), 0
                )

                -- CAS latency (up to 5)
                + CASE
                    WHEN m.cas_latency IS NULL THEN 0
                    WHEN m.cas_latency < 14 THEN 5
                    WHEN m.cas_latency < 16 THEN 4
                    WHEN m.cas_latency < 18 THEN 3
                    WHEN m.cas_latency < 20 THEN 2
                    ELSE 1
                END

                -- First word latency (up to 2)
                + CASE
                    WHEN m.first_word_latency IS NULL THEN 0
                    WHEN m.first_word_latency < 10 THEN 2
                    WHEN m.first_word_latency < 12 THEN 1
                    ELSE 0
                END
            ) AS score
        FROM memory m
        WHERE m.price <= budget
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- motherboard function 
DELIMITER $$
CREATE FUNCTION `get_best_motherboard_id`(cpu_id INT, memory_id INT, budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;
    DECLARE cpu_tdp INT;
    DECLARE mem_modules INT;
    DECLARE mem_capacity INT;
    DECLARE mem_speed INT;
    DECLARE mem_color VARCHAR(100);
    
    -- Get CPU details (only need TDP now)
    SELECT tdp INTO cpu_tdp FROM cpu WHERE id = cpu_id;
    
    -- Get Memory details
    SELECT 
        CAST(SUBSTRING_INDEX(modules, 'x', 1) AS UNSIGNED),
        CAST(SUBSTRING_INDEX(modules, 'x', 1) AS UNSIGNED) * 
        CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(modules, 'x', -1), 'GB', 1) AS UNSIGNED),
        CAST(REGEXP_REPLACE(speed, '[^0-9]', '') AS UNSIGNED),
        color
    INTO mem_modules, mem_capacity, mem_speed, mem_color
    FROM memory WHERE id = memory_id;
    
    -- Find best matching motherboard
    SELECT mb.id INTO best_id
    FROM motherboard mb
    WHERE mb.price IS NOT NULL AND mb.price <= budget
    ORDER BY
        (
            -- 1. Socket priority (AM5 > LGA1700 > AM4 > sTRX4)
            CASE mb.socket
                WHEN 'AM5' THEN 30
                WHEN 'LGA1700' THEN 25
                WHEN 'AM4' THEN 20
                WHEN 'sTRX4' THEN 15
                ELSE 0
            END
            +
            
            -- 2. Memory module count compatibility
            CASE
                WHEN mem_modules <= IFNULL(mb.memory_slots, 0) THEN 20
                ELSE 0
            END
            +
            
            -- 3. Total memory capacity compatibility
            CASE
                WHEN mem_capacity <= IFNULL(mb.max_memory, 0) THEN 15
                ELSE 0
            END
            +
            
            -- 4. Memory speed support (approximate)
            CASE
                WHEN mem_speed <= IFNULL(CAST(REGEXP_REPLACE(mb.name, '.*(DDR[0-9]-[0-9]+).*', '$1') AS UNSIGNED), 0) THEN 10
                WHEN mb.name LIKE CONCAT('%', mem_speed, '%') THEN 8
                ELSE 0
            END
            +
            
            -- 5. Form factor preference (ATX preferred)
            CASE mb.form_factor
                WHEN 'ATX' THEN 5
                WHEN 'Micro ATX' THEN 3
                WHEN 'Mini ITX' THEN 1
                ELSE 0
            END
            +
            
            -- 6. Price efficiency (lower price within budget gets higher score)
            CASE
                WHEN mb.price > 0 THEN (budget - mb.price) * 0.01
                ELSE 0
            END
            +
            
            -- 7. VRM quality estimation (based on TDP support)
            CASE
                WHEN cpu_tdp <= 65 AND mb.price > 100 THEN 5
                WHEN cpu_tdp <= 105 AND mb.price > 150 THEN 5
                WHEN cpu_tdp > 105 AND mb.price > 200 THEN 5
                ELSE 0
            END
            +
            
            -- 8. Memory slots headroom for future upgrades
            CASE
                WHEN mb.memory_slots > mem_modules THEN 3
                ELSE 0
            END
            
        ) DESC,
        mb.price ASC -- Tiebreaker for same score
    LIMIT 1;
    
    RETURN best_id;
END$$
DELIMITER ;

-- os function 
DELIMITER $$
CREATE FUNCTION `get_best_os_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT o.id
    INTO best_id
    FROM os o
    WHERE o.price IS NOT NULL AND o.price <= budget
    ORDER BY 
        o.max_memory DESC,
        o.price DESC,
        CASE 
            WHEN o.name LIKE '%Windows 11%' THEN 1
            WHEN o.name LIKE '%Windows 10%' THEN 0
            ELSE -1
        END DESC,
        CASE 
            WHEN o.name LIKE '%Pro%' THEN 1
            ELSE 0
        END DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- power supply function 
DELIMITER $$
CREATE FUNCTION `get_best_power_supply_id`(budget DECIMAL(10,2),exp_power INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT ps.id,
            (
                -- Efficiency rating (up to 6 points)
                CASE
                    WHEN LOWER(ps.efficiency) LIKE '%titanium%' THEN 6
                    WHEN LOWER(ps.efficiency) LIKE '%platinum%' THEN 5
                    WHEN LOWER(ps.efficiency) LIKE '%gold%' THEN 4
                    WHEN LOWER(ps.efficiency) LIKE '%silver%' THEN 3
                    WHEN LOWER(ps.efficiency) LIKE '%bronze%' THEN 2
                    WHEN ps.efficiency IS NOT NULL THEN 1
                    ELSE 0
                END

                -- Modularity (up to 4 points)
                + CASE
                    WHEN LOWER(ps.modular) LIKE '%full%' THEN 4
                    WHEN LOWER(ps.modular) LIKE '%semi%' THEN 2
                    ELSE 0
                END
            ) AS score
        FROM power_supply ps
        WHERE ps.price <= budget
		AND ps.wattage >= exp_power
    ) AS scored
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;


-- thermal paste function 
DELIMITER $$
CREATE FUNCTION `get_best_thermal_paste_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT tp.id
    INTO best_id
    FROM thermal_paste tp
    WHERE tp.price IS NOT NULL AND tp.price <= budget
    ORDER BY tp.price DESC, tp.amount DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;

-- video card function 
DELIMITER $$
CREATE FUNCTION `get_best_video_card_id`(budget DECIMAL(10,2)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE best_id INT;

    SELECT id INTO best_id
    FROM (
        SELECT vc.id,
            (
                -- Memory Score
                CASE
                    WHEN vc.memory >= 24 THEN 10
                    WHEN vc.memory >= 16 THEN 9
                    WHEN vc.memory >= 12 THEN 8
                    WHEN vc.memory >= 8 THEN 6
                    WHEN vc.memory >= 6 THEN 5
                    WHEN vc.memory >= 4 THEN 4
                    WHEN vc.memory >= 2 THEN 3
                    ELSE 1
                END
                +
                -- Boost Clock Score
                CASE
                    WHEN vc.boost_clock >= 2500 THEN 10
                    WHEN vc.boost_clock >= 2000 THEN 8
                    WHEN vc.boost_clock >= 1700 THEN 6
                    WHEN vc.boost_clock >= 1500 THEN 4
                    WHEN vc.boost_clock >= 1300 THEN 3
                    ELSE 1
                END
                +
                -- Core Clock Score
                CASE
                    WHEN vc.core_clock >= 2000 THEN 6
                    WHEN vc.core_clock >= 1600 THEN 5
                    WHEN vc.core_clock >= 1300 THEN 4
                    WHEN vc.core_clock >= 1000 THEN 3
                    ELSE 1
                END
                +
                -- Chipset Score
                CASE
                    WHEN LOWER(vc.chipset) LIKE '%rtx a6000%' THEN 12
                    WHEN LOWER(vc.chipset) LIKE '%rtx 6000 ada%' THEN 12
                    WHEN LOWER(vc.chipset) LIKE '%quadro rtx 8000%' THEN 11
                    WHEN LOWER(vc.chipset) LIKE '%quadro rtx 6000%' THEN 10
                    WHEN LOWER(vc.chipset) LIKE '%rtx a5000%' THEN 9
                    WHEN LOWER(vc.chipset) LIKE '%rtx 4000%' THEN 8
                    WHEN LOWER(vc.chipset) LIKE '%4090%' THEN 11
                    WHEN LOWER(vc.chipset) LIKE '%4080%' THEN 10
                    WHEN LOWER(vc.chipset) LIKE '%3090%' THEN 9
                    WHEN LOWER(vc.chipset) LIKE '%3080%' THEN 8
                    WHEN LOWER(vc.chipset) LIKE '%2080%' THEN 6
                    WHEN LOWER(vc.chipset) LIKE '%1080%' THEN 5
                    WHEN LOWER(vc.chipset) LIKE '%1060%' THEN 4
                    WHEN LOWER(vc.chipset) LIKE '%rx 6900%' THEN 10
                    WHEN LOWER(vc.chipset) LIKE '%rx 6800%' THEN 9
                    WHEN LOWER(vc.chipset) LIKE '%rx 5700%' THEN 8
                    WHEN LOWER(vc.chipset) LIKE '%rx 5600%' THEN 7
                    WHEN LOWER(vc.chipset) LIKE '%rx 5500%' THEN 6
                    WHEN LOWER(vc.chipset) LIKE '%rx%' OR LOWER(vc.chipset) LIKE '%radeon%' THEN 4
                    WHEN LOWER(vc.chipset) LIKE '%gtx%' OR LOWER(vc.chipset) LIKE '%gt%' THEN 3
                    WHEN LOWER(vc.chipset) LIKE '%integrated%' THEN 2
                    ELSE 1
                END
            ) AS score
        FROM video_card vc
        WHERE vc.price <= budget
    ) AS scored_cards
    ORDER BY score DESC
    LIMIT 1;

    RETURN best_id;
END$$
DELIMITER ;
