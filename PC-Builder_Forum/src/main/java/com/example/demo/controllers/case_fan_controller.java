package com.example.demo.controllers;

import com.example.demo.bases.case_fan;
import com.example.demo.repositories.case_fan_repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/case-fan")
public class case_fan_controller {

    @Autowired
    private case_fan_repo caseFanRepo;

    // Get all case fans
    @GetMapping
    public List<case_fan> getAllCaseFans() {
        return caseFanRepo.findAll();
    }

    // Get a case fan by ID
    @GetMapping("/{id}")
    public case_fan getCaseFanByIdPath(@PathVariable("id") Integer id) {
        return caseFanRepo.findById(id).orElse(null);
    }

    // Delete a case fan by ID
    @DeleteMapping("/remove/{id}")
    public boolean deleteCaseFan(@PathVariable("id") Integer id) {
        if (caseFanRepo.existsById(id)) {
            caseFanRepo.deleteById(id);
            return true;
        }
        return false;
    }

    // Update an existing case fan
    @PutMapping("/update/{id}")
    public case_fan updateCaseFan(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<case_fan> caseFanOpt = caseFanRepo.findById(id);
        if (caseFanOpt.isPresent()) {
        	case_fan caseFan = caseFanOpt.get();

            caseFan.setName(body.get("name"));
            caseFan.setPrice(new BigDecimal(body.get("price")));
            caseFan.setSize(Integer.parseInt(body.get("size")));
            caseFan.setColor(body.get("color"));
            caseFan.setRpm(body.get("rpm"));
            caseFan.setAirflow(body.get("airflow"));
            caseFan.setNoiseLevel(body.get("noiseLevel"));
            caseFan.setPwm(Boolean.parseBoolean(body.get("pwm")));

            return caseFanRepo.save(caseFan);
        } else {
            throw new RuntimeException("CaseFan not found with id " + id);
        }
    }

    // Create a new case fan
    @PostMapping("/add")
    public case_fan createCaseFan(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            Integer size = Integer.parseInt(body.get("size"));
            String color = body.get("color");
            String rpm = body.get("rpm");
            String airflow = body.get("airflow");
            String noiseLevel = body.get("noiseLevel");
            Boolean pwm = Boolean.parseBoolean(body.get("pwm"));

            case_fan caseFan = new case_fan(name, price, size, color, rpm, airflow, noiseLevel, pwm);
            return caseFanRepo.save(caseFan);

        } catch (NumberFormatException e) {
            throw new RuntimeException("Invalid number format", e);
        } catch (Exception e) {
            throw new RuntimeException("Error creating CaseFan", e);
        }
    }
}
