package com.example.demo.controllers;

import com.example.demo.bases.memory;
import com.example.demo.repositories.memory_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/memory")
public class memory_controller {

    @Autowired
    private memory_repo repo;

    @GetMapping
    public List<memory> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public memory getById(@PathVariable("id") Integer id) {
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
    public memory update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<memory> optional = repo.findById(id);
        if (optional.isPresent()) {
            memory obj = optional.get();

            if (body.containsKey("name")) obj.setName(body.get("name"));
            if (body.containsKey("price")) obj.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("speed")) obj.setSpeed(body.get("speed"));
            if (body.containsKey("modules")) obj.setModules(body.get("modules"));
            if (body.containsKey("pricePerGb")) obj.setPricePerGb(new BigDecimal(body.get("pricePerGb")));
            if (body.containsKey("color")) obj.setColor(body.get("color"));
            if (body.containsKey("firstWordLatency")) obj.setFirstWordLatency(new BigDecimal(body.get("firstWordLatency")));
            if (body.containsKey("casLatency")) obj.setCasLatency(new BigDecimal(body.get("casLatency")));

            return repo.save(obj);
        } else {
            throw new RuntimeException("Memory not found with id " + id);
        }
    }

    @PostMapping("/add")
    public memory create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String speed = body.get("speed");
            String modules = body.get("modules");
            BigDecimal pricePerGb = new BigDecimal(body.get("pricePerGb"));
            String color = body.get("color");
            BigDecimal firstWordLatency = new BigDecimal(body.get("firstWordLatency"));
            BigDecimal casLatency = new BigDecimal(body.get("casLatency"));

            memory obj = new memory(name, price, speed, modules, pricePerGb, color, firstWordLatency, casLatency);
            return repo.save(obj);

        } catch (Exception e) {
            throw new RuntimeException("Error creating Memory", e);
        }
    }
}
