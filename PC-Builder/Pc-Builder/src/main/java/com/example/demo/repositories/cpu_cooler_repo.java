package com.example.demo.repositories;

import com.example.demo.bases.cpu_cooler;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface cpu_cooler_repo extends JpaRepository<cpu_cooler, Integer> {
}
