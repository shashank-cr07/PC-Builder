package com.example.demo.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class main_controller{
	@GetMapping("/")
    public String showHomePage() {
        return "Choose"; 
    }
    @GetMapping("/home-pc")
    public String showHomePcPage() {
        return "Home-pc"; 
    }
    @GetMapping("/cpu-page")
    public String showCpuPage() {
        return "create-post"; 
    }
    @GetMapping("/gpu-page")
    public String showGpuPage() {
        return "Gpu"; 
    }
    @GetMapping("/motherboard-page")
    public String showMotherboardPage() {
        return "Motherboard"; 
    }
}