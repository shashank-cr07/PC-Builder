package com.example.demo.controllers;

import com.example.demo.bases.video_card;
import com.example.demo.repositories.video_card_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/video-card")
public class video_card_controller {

    @Autowired
    private video_card_repo repo;

    @GetMapping
    public List<video_card> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public video_card getById(@PathVariable("id") Integer id) {
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
    public List<video_card> findName(@RequestParam String name) {
        return repo.findByNameContainingIgnoreCase(name);
    }

    @PutMapping("/update/{id}")
    public video_card update(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<video_card> optional = repo.findById(id);
        if (optional.isPresent()) {
            video_card card = optional.get();

            if (body.containsKey("name")) card.setName(body.get("name"));
            if (body.containsKey("price")) card.setPrice(new BigDecimal(body.get("price")));
            if (body.containsKey("chipset")) card.setChipset(body.get("chipset"));
            if (body.containsKey("memory")) card.setMemory(new BigDecimal(body.get("memory")));
            if (body.containsKey("core_clock")) card.setCore_clock(Integer.parseInt(body.get("core_clock")));
            if (body.containsKey("boost_clock")) card.setBoost_clock(Integer.parseInt(body.get("boost_clock")));
            if (body.containsKey("color")) card.setColor(body.get("color"));
            if (body.containsKey("length")) card.setLength(Integer.parseInt(body.get("length")));

            return repo.save(card);
        } else {
            throw new RuntimeException("Video card not found with id " + id);
        }
    }

    @PostMapping("/add")
    public video_card create(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String chipset = body.get("chipset");
            BigDecimal memory = new BigDecimal(body.get("memory"));
            Integer core_clock = Integer.parseInt(body.get("core_clock"));
            Integer boost_clock = Integer.parseInt(body.get("boost_clock"));
            String color = body.get("color");
            Integer length = Integer.parseInt(body.get("length"));

            video_card card = new video_card(name, price, chipset, memory, core_clock, boost_clock, color, length);
            return repo.save(card);
        } catch (Exception e) {
            throw new RuntimeException("Error creating video card entry", e);
        }
    }
}
