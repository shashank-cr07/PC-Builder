package com.example.Forums.repository;

import com.example.Forums.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {

    // Fetch posts by forumId
    List<Post> findByForumId(int forumId);

    // Fetch all posts by userId, along with their comments and forum
    @Query("SELECT DISTINCT p FROM Post p " +
           "LEFT JOIN FETCH p.forum f " +  // Fetch the forum associated with the post
           "LEFT JOIN FETCH p.comments c " +  // Fetch the comments associated with the post
           "WHERE p.user.id = :userId")  // Filter posts by userId
    List<Post> findAllByUserIdWithComments(@Param("userId") int userId);

}
