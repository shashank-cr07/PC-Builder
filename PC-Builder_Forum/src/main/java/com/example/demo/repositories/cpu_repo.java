package com.example.demo.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.example.demo.bases.cpu;

import java.util.*;
@Repository
public interface cpu_repo extends JpaRepository<cpu, Integer> {
    
    List<cpu> findByNameContainingIgnoreCase(String name);

     @Query(value = "select get_best_cpu_id(:budget)", nativeQuery = true)
	    Integer get_best_cpu_id(Float budget);
 
}
