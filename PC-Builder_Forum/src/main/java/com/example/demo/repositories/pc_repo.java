package com.example.demo.repositories;

import com.example.demo.bases.Pc;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface pc_repo extends JpaRepository<Pc, Long> {

    @Query("SELECT p FROM Pc p WHERE p.User.id = :userId")
    List<Pc> findAllByUserId(@Param("userId") int userId);
}
