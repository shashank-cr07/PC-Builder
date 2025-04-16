package com.example.demo.repositories;

import com.example.demo.bases.motherboard;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface motherboard_repo extends JpaRepository<motherboard, Integer> {
    
    @Query(value = "select get_best_motherboard_id(:cpuId,:memoryId,:budget)", nativeQuery = true)
	    Integer get_best_motherboard_id(Integer cpuId,Integer memoryId,Float budget);
}
