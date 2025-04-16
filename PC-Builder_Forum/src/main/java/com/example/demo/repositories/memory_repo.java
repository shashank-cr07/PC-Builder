package com.example.demo.repositories;

import com.example.demo.bases.memory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface memory_repo extends JpaRepository<memory, Integer> {

    @Query(value = "select get_best_memory_id(:budget)", nativeQuery = true)
	    Integer get_best_memory_id(Float budget);
}
