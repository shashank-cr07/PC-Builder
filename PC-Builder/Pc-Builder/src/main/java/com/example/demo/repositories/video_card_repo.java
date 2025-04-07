package com.example.demo.repositories;

import com.example.demo.bases.video_card;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface video_card_repo extends JpaRepository<video_card, Integer> {
}
