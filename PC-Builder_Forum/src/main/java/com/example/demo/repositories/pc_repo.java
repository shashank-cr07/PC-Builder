package com.example.demo.repositories;

import com.example.demo.bases.Pc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface pc_repo extends JpaRepository<Pc,Long>{
    
}