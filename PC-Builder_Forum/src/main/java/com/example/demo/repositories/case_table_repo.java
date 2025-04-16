package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.example.demo.bases.case_table;

@Repository
public interface case_table_repo extends JpaRepository<case_table, Integer> {
    
    List<case_table> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_case_id(:mbId,:budget)", nativeQuery = true)
	    Integer get_best_case_id(Integer mbId,Float budget);
}
