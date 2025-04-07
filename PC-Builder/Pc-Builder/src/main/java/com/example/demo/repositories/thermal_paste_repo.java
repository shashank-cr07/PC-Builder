package com.example.demo.repositories;

import com.example.demo.bases.thermal_paste;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface thermal_paste_repo extends JpaRepository<thermal_paste, Integer> {
}
