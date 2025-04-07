package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "video_card")
public class video_card {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 100)
    private String chipset;

    @Column(precision = 10, scale = 2)
    private BigDecimal memory;

    private Integer core_clock;
    private Integer boost_clock;

    @Column(length = 50)
    private String color;

    private Integer length;

    public video_card() {}

    public video_card(String name, BigDecimal price, String chipset, BigDecimal memory,
                      Integer core_clock, Integer boost_clock, String color, Integer length) {
        this.name = name;
        this.price = price;
        this.chipset = chipset;
        this.memory = memory;
        this.core_clock = core_clock;
        this.boost_clock = boost_clock;
        this.color = color;
        this.length = length;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getChipset() { return chipset; }
    public void setChipset(String chipset) { this.chipset = chipset; }

    public BigDecimal getMemory() { return memory; }
    public void setMemory(BigDecimal memory) { this.memory = memory; }

    public Integer getCore_clock() { return core_clock; }
    public void setCore_clock(Integer core_clock) { this.core_clock = core_clock; }

    public Integer getBoost_clock() { return boost_clock; }
    public void setBoost_clock(Integer boost_clock) { this.boost_clock = boost_clock; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public Integer getLength() { return length; }
    public void setLength(Integer length) { this.length = length; }
}
