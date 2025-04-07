package com.example.demo.repositories;

import com.example.demo.bases.power_supply;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface power_supply_repo extends JpaRepository<power_supply, Integer> {
}
