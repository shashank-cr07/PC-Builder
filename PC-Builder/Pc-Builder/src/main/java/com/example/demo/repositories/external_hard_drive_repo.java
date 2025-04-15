package com.example.demo.repositories;

import com.example.demo.bases.external_hard_drive;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

@Repository
public interface external_hard_drive_repo extends JpaRepository<external_hard_drive, Integer> {
    

    @Query(value = "select get_best_external_drive_id(:budget)", nativeQuery = true)
	    Integer get_best_external_drive_id(Float budget);
}
