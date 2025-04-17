package com.example.demo.controllers;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.example.demo.bases.cpu;

import jakarta.servlet.http.HttpSession;

@Controller
public class session_controller{

    @PostMapping("/clear-session")
    public void clearSession(HttpSession session) {
        session.removeAttribute("username"); // Removes the 'username' session attribute
    }
    @PostMapping("/session/set-selected-cpu")
    public ResponseEntity<Void> setSelectedCpu(@RequestBody cpu selectedCpu, HttpSession session) {
        session.setAttribute("selectedCpu", selectedCpu);
        return ResponseEntity.ok().build();
    }
        @GetMapping("/session/get-selected-cpu")
    public ResponseEntity<cpu> getSelectedCpu(HttpSession session) {
        cpu selectedCpu = (cpu) session.getAttribute("selectedCpu");
        if (selectedCpu != null) {
            return ResponseEntity.ok(selectedCpu);
        } else {
            return ResponseEntity.noContent().build();
        }
    }
        @PostMapping("/session/clear-selected-cpu")
    public ResponseEntity<Void> clearSelectedCpu(HttpSession session) {
        session.removeAttribute("selectedCpu");
        return ResponseEntity.ok().build();
    }


}
