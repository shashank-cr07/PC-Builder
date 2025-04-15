package com.example.demo.repositories;

import com.example.demo.bases.video_card;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface video_card_repo extends JpaRepository<video_card, Integer> {

    @Query(value = "select get_best_video_card_id(:budget)", nativeQuery = true)
	    Integer get_best_video_card_id(Float budget);
}
