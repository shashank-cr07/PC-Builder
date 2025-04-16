package com.example.demo.controllers;

import com.example.demo.bases.Forum;
import com.example.demo.bases.Comment;
import com.example.demo.bases.Post;
import com.example.demo.bases.User;
import com.example.demo.repositories.PostRepository;
import com.example.demo.repositories.ForumRepository;
import com.example.demo.repositories.UserRepository;
import com.example.demo.repositories.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@SessionAttributes("loggedInUser")
public class PostController {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private ForumRepository forumRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CommentRepository commentRepository;

    @ModelAttribute("loggedInUser")
    public User loggedInUser(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        return user != null ? user : null;
    }

    @GetMapping("/create-post")
    public String showCreatePostPage(@RequestParam("forumId") int forumId,
                                     @ModelAttribute("loggedInUser") User user,
                                     Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        Forum forum = forumRepository.findById(forumId).orElse(null);
        if (forum == null) {
            return "redirect:/home";
        }

        model.addAttribute("forum", forum);
        model.addAttribute("username", user.getUsername());
        return "create-post";
    }

    @PostMapping("/create-post")
    public String createPost(@RequestParam("content") String content,
                             @RequestParam("forumId") int forumId,
                             @ModelAttribute("loggedInUser") User user) {
        if (user == null) {
            return "redirect:/login";
        }

        Forum forum = forumRepository.findById(forumId).orElse(null);
        if (forum == null) {
            return "redirect:/home";
        }

        Post post = new Post();
        post.setContent(content);
        post.setForum(forum);
        post.setUser(user);

        postRepository.save(post);
        return "redirect:/forum/" + forumId;
    }

    @GetMapping("/post/{id}")
    public String viewPost(@PathVariable("id") int postId,
                           @ModelAttribute("loggedInUser") User user,
                           Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        Post post = postRepository.findById(postId).orElse(null);
        if (post == null) {
            return "redirect:/home";
        }

        model.addAttribute("post", post);
        model.addAttribute("forum", post.getForum());
        model.addAttribute("comments", post.getComments());
        model.addAttribute("username", user.getUsername());

        return "post-detail";
    }

    @GetMapping("/my-posts")
    public String viewMyPosts(@ModelAttribute("loggedInUser") User user,
                              Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        // Fetch posts of the logged-in user along with their comments
        List<Post> myPosts = postRepository.findAllByUserIdWithComments(user.getId());

        // Map to store comments for each post
        Map<Integer, List<Map<String, Object>>> postCommentsMap = new HashMap<>();

        // Loop through each post to fetch the associated comments and user names
        for (Post post : myPosts) {
            List<Comment> comments = commentRepository.findByPostId(post.getId());
            List<Map<String, Object>> commentDataList = new ArrayList<>();
            
            for (Comment comment : comments) {
                Optional<User> commentUserOpt = userRepository.findById(comment.getUserId());
                String commentUsername = commentUserOpt.map(User::getUsername).orElse("Unknown");

                Map<String, Object> commentData = new HashMap<>();
                commentData.put("comment", comment);
                commentData.put("username", commentUsername);

                commentDataList.add(commentData);
            }

            // Store the list of comments for this post in the map
            postCommentsMap.put(post.getId(), commentDataList);
        }

        // Add posts and comments to the model
        model.addAttribute("postsData", myPosts);
        model.addAttribute("commentsMap", postCommentsMap);
        model.addAttribute("username", user.getUsername());
        return "my-posts";
    }
}


