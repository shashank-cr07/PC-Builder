package com.example.demo.repositories;

import com.example.demo.bases.os;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface os_repo extends JpaRepository<os, Integer> {
    
    List<os> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_os_id(:budget)", nativeQuery = true)
	    Integer get_best_os_id(Float budget);
}
