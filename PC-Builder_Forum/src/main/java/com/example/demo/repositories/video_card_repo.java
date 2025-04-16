package com.example.demo.repositories;

import com.example.demo.bases.video_card;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface video_card_repo extends JpaRepository<video_card, Integer> {

    List<video_card> findByNameContainingIgnoreCase(String name);


    @Query(value = "select get_best_video_card_id(:budget)", nativeQuery = true)
	    Integer get_best_video_card_id(Float budget);
}
