package com.example.demo.repositories;

import com.example.demo.bases.fan_controller;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface fan_controller_repo extends JpaRepository<fan_controller, Integer> {
}
