package com.example.demo.controllers;

import com.example.demo.bases.Pc;
import com.example.demo.bases.User;
import com.example.demo.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/builds")
@SessionAttributes("loggedInUser")
public class viewBuildController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String getUserPcBuilds(@ModelAttribute("loggedInUser") User user, Model model) {
        System.out.println(user.getId());
        List<Pc> pcBuilds = userService.getPcBuildsByUserId(user.getId());       
        model.addAttribute("pcBuilds", pcBuilds);

        return "userBuilds"; // This should map to userBuilds.jsp
    }
}