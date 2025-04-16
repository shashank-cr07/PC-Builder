package com.example.demo.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpSession;

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
    @GetMapping("/cpupage")
    public String showCpuPage() {
        return "Cpu"; 
    }
    @GetMapping("/case-fanpage")
    public String showCaseFanPage() {
        return "case-fan"; 
    }

    @GetMapping("/case-tablepage")
    public String showCaseTablePage() {
        return "case-table"; 
    }

    @GetMapping("/cpu-coolerpage")
    public String showCpuCoolerPage() {
        return "cpu-cooler"; 
    }

    @GetMapping("/external-hard-drivepage")
    public String showEHDPage() {
        return "external-hard-drive"; 
    }

    @GetMapping("/fan-controllerpage")
    public String showFanControllerPage() {
        return "fan-controller"; 
    }

    @GetMapping("/internal-hard-drivepage")
    public String showIHDPage() {
        return "internal-hard-drive"; 
    }

    @GetMapping("/ospage")
    public String showOSPage() {
        return "os"; 
    }

    @GetMapping("/power-supplypage")
    public String showPowerSupplyPage() {
        return "power-supply"; 
    }

    @GetMapping("/thermal-pastepage")
    public String showThermalPastePage() {
        return "thermal-paste"; 
    }

    @GetMapping("/video-cardpage")
    public String showVideoCardPage() {
        return "video-card"; 
    }

    @GetMapping("/motherboardpage")
    public String showMotherboardPage() {
        return "Motherboard"; 
    }

    @GetMapping("/memorypage")
    public String showMemoryPage() {
        return "memory"; 
    }
    @PostMapping("/clear-session")
    public void clearSession(HttpSession session) {
        session.removeAttribute("username"); // Removes the 'username' session attribute
    }
}
