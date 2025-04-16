package com.example.demo.controllers;

import com.example.demo.bases.Pc;
import com.example.demo.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/pc")
public class pc_controller {

    @Autowired
    private UserService userService;

    @PostMapping("/save")
    public String savePcBuild(@RequestBody Pc pc) {
        return userService.savePcBuild_user(pc);
    }
}