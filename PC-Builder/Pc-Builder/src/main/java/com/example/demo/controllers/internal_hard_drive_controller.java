package com.example.demo.controllers;

import com.example.demo.bases.internal_hard_drive;
import com.example.demo.repositories.internal_hard_drive_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/internal-hard-drive")
public class internal_hard_drive_controller {

    @Autowired
    private internal_hard_drive_repo repo;

    @GetMapping
    public List<internal_hard_drive> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public internal_hard_drive getById(@PathVariable("id") Integer id) {
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
    public internal_hard_drive update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<internal_hard_drive> optional = repo.findById(id);
        if (optional.isPresent()) {
            internal_hard_drive obj = optional.get();

            if (body.containsKey("name")) obj.setName(body.get("name"));
            if (body.containsKey("price")) obj.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("capacity")) obj.setCapacity(new BigDecimal(body.get("capacity")));
            if (body.containsKey("pricePerGb")) obj.setPricePerGb(new BigDecimal(body.get("pricePerGb")));
            if (body.containsKey("type")) obj.setType(body.get("type"));
            if (body.containsKey("cache")) obj.setCache(Integer.parseInt(body.get("cache")));
            if (body.containsKey("formFactor")) obj.setFormFactor(body.get("formFactor"));
            if (body.containsKey("interfaceType")) obj.setInterfaceType(body.get("interfaceType"));

            return repo.save(obj);
        } else {
            throw new RuntimeException("Internal Hard Drive not found with id " + id);
        }
    }

    @PostMapping("/add")
    public internal_hard_drive create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            BigDecimal capacity = new BigDecimal(body.get("capacity"));
            BigDecimal pricePerGb = new BigDecimal(body.get("pricePerGb"));
            String type = body.get("type");
            Integer cache = Integer.parseInt(body.get("cache"));
            String formFactor = body.get("formFactor");
            String interfaceType = body.get("interfaceType");

            internal_hard_drive obj = new internal_hard_drive(name, price, capacity, pricePerGb, type, cache, formFactor, interfaceType);
            return repo.save(obj);

        } catch (Exception e) {
            throw new RuntimeException("Error creating Internal Hard Drive", e);
        }
    }
}
