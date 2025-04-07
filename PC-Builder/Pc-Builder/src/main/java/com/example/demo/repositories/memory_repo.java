package com.example.demo.repositories;

import com.example.demo.bases.memory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface memory_repo extends JpaRepository<memory, Integer> {
}
