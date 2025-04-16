package com.example.demo.controllers;

import java.util.List;

import com.example.demo.bases.Forum;
import com.example.demo.bases.User;
import com.example.demo.repositories.ForumRepository;
import com.example.demo.repositories.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

@Controller
@SessionAttributes("loggedInUser") // Store this user in session once logged in
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ForumRepository forumRepository;

    // Required to initialize the session attribute
    @ModelAttribute("loggedInUser")
    public User loggedInUser() {
        return null; // It will be set after login
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute User user, Model model) {
        userRepository.save(user);
        model.addAttribute("message", "Registration successful!");
        return "login";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(
            @RequestParam String username,
            @RequestParam String password,
            Model model) {

        User existing = userRepository.findByUsername(username);

        if (existing != null && existing.getPassword().equals(password)) {
            model.addAttribute("loggedInUser", existing); // store in session
            System.out.println(">>> Logging in: " + existing.getUsername() + ", ID: " + existing.getId());
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid credentials!");
            return "login";
        }
    }

    @GetMapping("/home")
    public String showHomePage(@ModelAttribute("loggedInUser") User user, Model model) {
        if (user == null) {
            return "redirect:/login";
        }

        List<Forum> forums = forumRepository.findAll();
        model.addAttribute("username", user.getUsername());
        model.addAttribute("forums", forums);
        return "home";
    }

    @GetMapping("/logout")
    public String logout(SessionStatus status) {
        status.setComplete(); // Clear session attributes managed by @SessionAttributes
        return "redirect:/login";
    }
}
