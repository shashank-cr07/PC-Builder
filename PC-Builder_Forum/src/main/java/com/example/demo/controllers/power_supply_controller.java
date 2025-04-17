package com.example.demo.controllers;

import com.example.demo.bases.power_supply;
import com.example.demo.repositories.power_supply_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/power-supply")
public class power_supply_controller {

    @Autowired
    private power_supply_repo repo;

    @GetMapping
    public List<power_supply> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public power_supply getById(@PathVariable("id") Integer id) {
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

    @PutMapping("/update/{id}")
    public power_supply update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<power_supply> optional = repo.findById(id);
        if (optional.isPresent()) {
            power_supply psu = optional.get();

            if (body.containsKey("name")) psu.setName(body.get("name"));
            if (body.containsKey("price")) psu.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("type")) psu.setType(body.get("type"));
            if (body.containsKey("efficiency")) psu.setEfficiency(body.get("efficiency"));
            if (body.containsKey("wattage")) psu.setWattage(Integer.parseInt(body.get("wattage")));
            if (body.containsKey("modular")) psu.setModular(body.get("modular"));
            if (body.containsKey("color")) psu.setColor(body.get("color"));

            return repo.save(psu);
        } else {
            throw new RuntimeException("Power supply not found with id " + id);
        }
    }
    @GetMapping("/name-search")
    public List<power_supply> findNameCpu(@RequestParam String name) {
        return repo.findByNameContainingIgnoreCase(name);
    }

    @PostMapping("/add")
    public power_supply create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String type = body.get("type");
            String efficiency = body.get("efficiency");
            Integer wattage = Integer.parseInt(body.get("wattage"));
            String modular = body.get("modular");
            String color = body.get("color");

            power_supply psu = new power_supply(name, price, type, efficiency, wattage, modular, color);
            return repo.save(psu);
        } catch (Exception e) {
            throw new RuntimeException("Error creating power supply entry", e);
        }
    }
}
