package com.example.demo.repositories;

import com.example.demo.bases.external_hard_drive;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface external_hard_drive_repo extends JpaRepository<external_hard_drive, Integer> {
}
