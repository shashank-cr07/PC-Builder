package com.example.demo.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class main_controller{
	@GetMapping("/")
    public String showHomePage() {
        return "Home"; 
    }
    @GetMapping("/cpu-page")
    public String showCpuPage() {
        return "Cpu"; 
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