package com.example.demo.repositories;

import com.example.demo.bases.fan_controller;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import org.springframework.stereotype.Repository;

@Repository
public interface fan_controller_repo extends JpaRepository<fan_controller, Integer> {
    
    List<fan_controller> findByNameContainingIgnoreCase(String name);

    @Query(value = "select get_best_fan_controller_id(:budget)", nativeQuery = true)
	    Integer get_best_fan_controller_id(Float budget);
}
