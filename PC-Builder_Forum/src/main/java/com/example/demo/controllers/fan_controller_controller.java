package com.example.demo.controllers;

import com.example.demo.bases.fan_controller;
import com.example.demo.repositories.fan_controller_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/fan-controller")
public class fan_controller_controller {

    @Autowired
    private fan_controller_repo repo;

    @GetMapping
    public List<fan_controller> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public fan_controller getById(@PathVariable("id") Integer id) {
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
    public fan_controller update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<fan_controller> optional = repo.findById(id);
        if (optional.isPresent()) {
            fan_controller obj = optional.get();

            if (body.containsKey("name")) obj.setName(body.get("name"));
            if (body.containsKey("price")) obj.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("channels")) obj.setChannels(Integer.parseInt(body.get("channels")));
            if (body.containsKey("channelWattage")) obj.setChannelWattage(new BigDecimal(body.get("channelWattage")));
            if (body.containsKey("pwm")) obj.setPwm(Boolean.parseBoolean(body.get("pwm")));
            if (body.containsKey("formFactor")) obj.setFormFactor(body.get("formFactor"));
            if (body.containsKey("color")) obj.setColor(body.get("color"));

            return repo.save(obj);
        } else {
            throw new RuntimeException("Fan controller not found with id " + id);
        }
    }

    @PostMapping("/add")
    public fan_controller create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            Integer channels = Integer.parseInt(body.get("channels"));
            BigDecimal channelWattage = new BigDecimal(body.get("channelWattage"));
            Boolean pwm = Boolean.parseBoolean(body.get("pwm"));
            String formFactor = body.get("formFactor");
            String color = body.get("color");

            fan_controller obj = new fan_controller(name, price, channels, channelWattage, pwm, formFactor, color);
            return repo.save(obj);

        } catch (Exception e) {
            throw new RuntimeException("Error creating Fan Controller", e);
        }
    }
}
