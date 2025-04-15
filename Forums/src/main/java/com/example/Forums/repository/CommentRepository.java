package com.example.Forums.repository;

import com.example.Forums.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
    // Find comments by Post ID
    List<Comment> findByPostId(int postId);
    
    // Find comments by User ID
    List<Comment> findAllByUserId(int userId);
}
