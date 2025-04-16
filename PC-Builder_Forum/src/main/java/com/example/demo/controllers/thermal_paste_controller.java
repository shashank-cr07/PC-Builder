package com.example.demo.controllers;

import com.example.demo.bases.thermal_paste;
import com.example.demo.repositories.thermal_paste_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/thermal-paste")
public class thermal_paste_controller {

    @Autowired
    private thermal_paste_repo repo;

    @GetMapping
    public List<thermal_paste> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public thermal_paste getById(@PathVariable("id") Integer id) {
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
    public thermal_paste update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<thermal_paste> optional = repo.findById(id);
        if (optional.isPresent()) {
            thermal_paste paste = optional.get();

            if (body.containsKey("name")) paste.setName(body.get("name"));
            if (body.containsKey("price")) paste.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("amount")) paste.setAmount(new BigDecimal(body.get("amount")));

            return repo.save(paste);
        } else {
            throw new RuntimeException("Thermal paste not found with id " + id);
        }
    }

    @PostMapping("/add")
    public thermal_paste create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            BigDecimal amount = new BigDecimal(body.get("amount"));

            thermal_paste paste = new thermal_paste(name, price, amount);
            return repo.save(paste);
        } catch (Exception e) {
            throw new RuntimeException("Error creating thermal paste entry", e);
        }
    }
}
