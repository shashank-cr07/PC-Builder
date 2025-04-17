package com.example.demo.controllers;

import com.example.demo.bases.motherboard;
import com.example.demo.repositories.motherboard_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/motherboard")
public class motherboard_controller {

    @Autowired
    private motherboard_repo repo;

    @GetMapping
    public List<motherboard> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public motherboard getById(@PathVariable("id") Integer id) {
        return repo.findById(id).orElse(null);
    }

    @DeleteMapping("/remove/{id}")
    public boolean delete(@PathVariable("id") Integer id) {
        if (repo.existsById(id)) {
            repo.deleteById(id);
            return true;
        }
        return false;
    }
    @GetMapping("/name-search")
    public List<motherboard> findNameCpu(@RequestParam String name) {
        return repo.findByNameContainingIgnoreCase(name);
    }
    @PutMapping("/update/{id}")
    public motherboard update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<motherboard> optional = repo.findById(id);
        if (optional.isPresent()) {
            motherboard obj = optional.get();

            if (body.containsKey("name")) obj.setName(body.get("name"));
            if (body.containsKey("price")) obj.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("socket")) obj.setSocket(body.get("socket"));
            if (body.containsKey("formFactor")) obj.setFormFactor(body.get("formFactor"));
            if (body.containsKey("maxMemory")) obj.setMaxMemory(Integer.parseInt(body.get("maxMemory")));
            if (body.containsKey("memorySlots")) obj.setMemorySlots(Integer.parseInt(body.get("memorySlots")));
            if (body.containsKey("color")) obj.setColor(body.get("color"));

            return repo.save(obj);
        } else {
            throw new RuntimeException("Motherboard not found with id " + id);
        }
    }

    @PostMapping("/add")
    public motherboard create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String socket = body.get("socket");
            String formFactor = body.get("formFactor");
            Integer maxMemory = Integer.parseInt(body.get("maxMemory"));
            Integer memorySlots = Integer.parseInt(body.get("memorySlots"));
            String color = body.get("color");

            motherboard obj = new motherboard(name, price, socket, formFactor, maxMemory, memorySlots, color);
            return repo.save(obj);
        } catch (Exception e) {
            throw new RuntimeException("Error creating Motherboard", e);
        }
    }
}
