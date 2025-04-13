package com.example.Forums.controller;

import com.example.Forums.model.Comment;
import com.example.Forums.model.Forum;
import com.example.Forums.model.Post;
import com.example.Forums.model.User;
import com.example.Forums.repository.CommentRepository;
import com.example.Forums.repository.ForumRepository;
import com.example.Forums.repository.PostRepository;
import com.example.Forums.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@SessionAttributes("loggedInUser")
public class ForumController {

    @Autowired
    private ForumRepository forumRepository;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CommentRepository commentRepository;

    @ModelAttribute("loggedInUser")
    public User loggedInUser() {
        return null; // ensures "loggedInUser" is available
    }

    @GetMapping("/create-forum")
    public String showCreateForumPage(@SessionAttribute("loggedInUser") User user, Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("username", user.getUsername());
        return "create-forum";
    }

    @PostMapping("/create-forum")
    public String createForum(@RequestParam String name,
                              @SessionAttribute("loggedInUser") User user) {
        if (user == null) {
            return "redirect:/login";
        }
        System.out.println("Forum Post >>> Logged in user: " + user.getUsername() + ", ID: " + user.getId());
        Forum forum = new Forum();
        forum.setName(name);
        forum.setCreatedBy(user.getId());

        forumRepository.save(forum);
        return "redirect:/home";
    }

    @GetMapping("/my-forums")
    public String myForums(@SessionAttribute("loggedInUser") User user, Model model) {
        if (user == null) {
            return "redirect:/login";
        }
        List<Forum> forums = forumRepository.findByCreatedBy(user.getId());
        model.addAttribute("forums", forums);
        model.addAttribute("username", user.getUsername());
        return "my-forums";
    }

    @GetMapping("/forum/{id}")
    public String viewForum(@PathVariable("id") int forumId,
                            @SessionAttribute("loggedInUser") User user,
                            Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        Forum forum = forumRepository.findById(forumId).orElse(null);
        if (forum == null) {
            return "redirect:/home";
        }

        List<Post> posts = postRepository.findByForumId(forumId);

        Map<Integer, List<Map<String, Object>>> postCommentsMap = new HashMap<>();
        List<Map<String, Object>> postDataList = new ArrayList<>();

        for (Post post : posts) {
            Optional<User> postUserOpt = userRepository.findById(post.getUserId());
            String postUsername = postUserOpt.map(User::getUsername).orElse("Unknown");

            Map<String, Object> postData = new HashMap<>();
            postData.put("post", post);
            postData.put("username", postUsername);

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

            postCommentsMap.put(post.getId(), commentDataList);
            postDataList.add(postData);
        }

        model.addAttribute("forum", forum);
        model.addAttribute("postsData", postDataList);
        model.addAttribute("commentsMap", postCommentsMap);
        model.addAttribute("username", user.getUsername());

        return "forum-detail";
    }
}
