package com.example.Forums.repository;

import com.example.Forums.model.Forum;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ForumRepository extends JpaRepository<Forum, Integer> {

    // Custom method to find forums created by a specific user
    List<Forum> findByCreatedBy(int createdBy);
}
