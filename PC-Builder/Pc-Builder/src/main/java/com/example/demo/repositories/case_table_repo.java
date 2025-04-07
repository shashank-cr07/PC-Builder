package com.example.demo.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.bases.case_table;

@Repository
public interface case_table_repo extends JpaRepository<case_table, Integer> {
}
