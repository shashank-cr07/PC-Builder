package com.example.demo.repositories;

import com.example.demo.bases.cpu_cooler;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface cpu_cooler_repo extends JpaRepository<cpu_cooler, Integer> {
    
    List<cpu_cooler> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_cpu_cooler_id(:budget)", nativeQuery = true)
	    Integer get_best_cpu_cooler_id(Float budget);
}
