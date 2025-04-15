package com.example.demo.repositories;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import org.springframework.stereotype.Repository;

import com.example.demo.bases.case_fan;


@Repository
public interface case_fan_repo extends JpaRepository<case_fan, Integer> {

    @Query(value = "select get_best_case_fan_id(:budget)", nativeQuery = true)
	    Integer get_best_case_fan_id(Float budget);
}