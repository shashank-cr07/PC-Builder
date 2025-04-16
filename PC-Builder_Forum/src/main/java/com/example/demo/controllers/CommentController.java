package com.example.demo.controllers;

import com.example.demo.bases.Comment;
import com.example.demo.bases.Post;
import com.example.demo.bases.User;
import com.example.demo.repositories.CommentRepository;
import com.example.demo.repositories.PostRepository;
import com.example.demo.repositories.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
@Controller
@SessionAttributes("loggedInUser")
public class CommentController {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/add-comment")
    public String addComment(
            @RequestParam("postId") int postId,
            @RequestParam("forumId") int forumId,
            @RequestParam("content") String content,
            @ModelAttribute("loggedInUser") User loggedInUser
    ) {
        Post post = postRepository.findById(postId).orElse(null);

        if (post == null || loggedInUser == null) {
            return "redirect:/login"; // Or some error page
        }

        Comment comment = new Comment();
        comment.setContent(content);
        comment.setPost(post);
        comment.setUserId(loggedInUser.getId());

        commentRepository.save(comment);

        // Redirect back to the forum page to see the comment
        return "redirect:/forum/" + forumId;
    }


}
