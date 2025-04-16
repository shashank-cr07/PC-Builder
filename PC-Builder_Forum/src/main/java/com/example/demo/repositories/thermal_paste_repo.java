package com.example.demo.repositories;

import com.example.demo.bases.thermal_paste;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface thermal_paste_repo extends JpaRepository<thermal_paste, Integer> {
    
    List<thermal_paste> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_thermal_paste_id(:budget)", nativeQuery = true)
	    Integer get_best_thermal_paste_id(Float budget);
}
