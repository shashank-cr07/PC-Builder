package com.example.demo.repositories;

import com.example.demo.bases.internal_hard_drive;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface internal_hard_drive_repo extends JpaRepository<internal_hard_drive, Integer> {

    @Query(value = "select get_best_internal_drive_id(:budget)", nativeQuery = true)
	    Integer get_best_internal_drive_id(Float budget);

}
