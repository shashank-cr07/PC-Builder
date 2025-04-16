package com.example.demo.repositories;

import com.example.demo.bases.memory;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface memory_repo extends JpaRepository<memory, Integer> {

    List<memory> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_memory_id(:budget)", nativeQuery = true)
	    Integer get_best_memory_id(Float budget);
}
