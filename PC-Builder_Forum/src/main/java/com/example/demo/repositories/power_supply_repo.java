package com.example.demo.repositories;

import com.example.demo.bases.power_supply;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface power_supply_repo extends JpaRepository<power_supply, Integer> {
    
    List<power_supply> findByNameContainingIgnoreCase(String name);

    @Query(value = "select get_best_power_supply_id(:budget,:exp_power)", nativeQuery = true)
	    Integer get_best_power_supply_id(Float budget, int exp_power);
}
