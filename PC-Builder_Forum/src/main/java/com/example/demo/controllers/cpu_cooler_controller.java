package com.example.demo.controllers;

import com.example.demo.bases.cpu_cooler;
import com.example.demo.repositories.cpu_cooler_repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/cpu-cooler")
public class cpu_cooler_controller {

    @Autowired
    private cpu_cooler_repo cpuCoolerRepo;

    @GetMapping
    public List<cpu_cooler> getAllCoolers() {
        return cpuCoolerRepo.findAll();
    }

    @GetMapping("/{id}")
    public cpu_cooler getCoolerById(@PathVariable("id") Integer id) {
        return cpuCoolerRepo.findById(id).orElse(null);
    }

    @DeleteMapping("/remove/{id}")
    public boolean deleteCooler(@PathVariable("id") Integer id) {
        if (cpuCoolerRepo.existsById(id)) {
            cpuCoolerRepo.deleteById(id);
            return true;
        }
        return false;
    }

    @GetMapping("/name-search")
    public List<cpu_cooler> findNameCpu(@RequestParam String name) {
        return cpuCoolerRepo.findByNameContainingIgnoreCase(name);
    }

    @PostMapping("/add")
    public cpu_cooler addCooler(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String rpm = body.get("rpm");
            String noiseLevel = body.get("noiseLevel");
            String color = body.get("color");
            String size = body.get("size");

            cpu_cooler cooler = new cpu_cooler(name, price, rpm, noiseLevel, color, size);
            return cpuCoolerRepo.save(cooler);
        } catch (Exception e) {
            throw new RuntimeException("Error creating CPU Cooler", e);
        }
    }

    @PutMapping("/update/{id}")
    public cpu_cooler updateCooler(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<cpu_cooler> coolerOpt = cpuCoolerRepo.findById(id);
        if (coolerOpt.isPresent()) {
            cpu_cooler cooler = coolerOpt.get();

            if (body.containsKey("name"))
                cooler.setName(body.get("name"));

            if (body.containsKey("price"))
                cooler.setPrice(new BigDecimal(body.get("price")));

            if (body.containsKey("rpm"))
                cooler.setRpm(body.get("rpm"));

            if (body.containsKey("noiseLevel"))
                cooler.setNoiseLevel(body.get("noiseLevel"));

            if (body.containsKey("color"))
                cooler.setColor(body.get("color"));

            if (body.containsKey("size"))
                cooler.setSize(body.get("size"));

            return cpuCoolerRepo.save(cooler);
        } else {
            throw new RuntimeException("CPU Cooler not found with id " + id);
        }
    }
}
