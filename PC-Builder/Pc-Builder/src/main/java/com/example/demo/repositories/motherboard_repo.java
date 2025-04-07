package com.example.demo.repositories;

import com.example.demo.bases.motherboard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface motherboard_repo extends JpaRepository<motherboard, Integer> {
}
