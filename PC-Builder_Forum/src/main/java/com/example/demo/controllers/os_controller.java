package com.example.demo.controllers;

import com.example.demo.bases.os;
import com.example.demo.repositories.os_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/os")
public class os_controller {

    @Autowired
    private os_repo repo;

    @GetMapping
    public List<os> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public os getById(@PathVariable("id") Integer id) {
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
    public os update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<os> optional = repo.findById(id);
        if (optional.isPresent()) {
            os obj = optional.get();

            if (body.containsKey("name")) obj.setName(body.get("name"));
            if (body.containsKey("price")) obj.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("mode")) obj.setMode(body.get("mode"));
            if (body.containsKey("maxMemory")) obj.setMaxMemory(Integer.parseInt(body.get("maxMemory")));

            return repo.save(obj);
        } else {
            throw new RuntimeException("OS not found with id " + id);
        }
    }
    @GetMapping("/name-search")
    public List<os> findName(@RequestParam String name) {
        return repo.findByNameContainingIgnoreCase(name);
    }

    @PostMapping("/add")
    public os create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String mode = body.get("mode");
            Integer maxMemory = Integer.parseInt(body.get("maxMemory"));

            os obj = new os(name, price, mode, maxMemory);
            return repo.save(obj);
        } catch (Exception e) {
            throw new RuntimeException("Error creating OS entry", e);
        }
    }
}
