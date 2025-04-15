package com.example.demo.controllers;

import com.example.demo.bases.cpu;
import com.example.demo.repositories.cpu_repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/cpu")
public class cpu_controller {

    @Autowired
    private cpu_repo cpuRepo;

    @GetMapping
    public List<cpu> getAllCPUs() {
        return cpuRepo.findAll();
    }
        @GetMapping("/name-search")
    public List<cpu> findNameCpu(@RequestParam String name) {
        return cpuRepo.findByNameContainingIgnoreCase(name);
    }

    @GetMapping("/{id}")
    public cpu getCPUById(@PathVariable("id") Integer id) {
        return cpuRepo.findById(id).orElse(null);
    }

    @DeleteMapping("/remove/{id}")
    public boolean deleteCPU(@PathVariable("id") Integer id) {
        if (cpuRepo.existsById(id)) {
            cpuRepo.deleteById(id);
            return true;
        }
        return false;
    }

    @PostMapping("/add")
    public cpu createCPU(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            Integer coreCount = Integer.parseInt(body.get("coreCount"));
            BigDecimal coreClock = new BigDecimal(body.get("coreClock"));
            BigDecimal boostClock = new BigDecimal(body.get("boostClock"));
            Integer tdp = Integer.parseInt(body.get("tdp"));
            String graphics = body.get("graphics");
            Boolean smt = Boolean.parseBoolean(body.get("smt"));

            cpu newCpu = new cpu(name, price, coreCount, coreClock, boostClock, tdp, graphics, smt);
            return cpuRepo.save(newCpu);

        } catch (Exception e) {
            throw new RuntimeException("Error creating CPU", e);
        }
    }

    @PutMapping("/update/{id}")
    public cpu updateCPU(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<cpu> cpuOpt = cpuRepo.findById(id);
        if (cpuOpt.isPresent()) {
            cpu cpuData = cpuOpt.get();

            if (body.containsKey("name"))
                cpuData.setName(body.get("name"));

            if (body.containsKey("price"))
                cpuData.setPrice(new BigDecimal(body.get("price")));

            if (body.containsKey("coreCount"))
                cpuData.setCoreCount(Integer.parseInt(body.get("coreCount")));

            if (body.containsKey("coreClock"))
                cpuData.setCoreClock(new BigDecimal(body.get("coreClock")));

            if (body.containsKey("boostClock"))
                cpuData.setBoostClock(new BigDecimal(body.get("boostClock")));

            if (body.containsKey("tdp"))
                cpuData.setTdp(Integer.parseInt(body.get("tdp")));

            if (body.containsKey("graphics"))
                cpuData.setGraphics(body.get("graphics"));

            if (body.containsKey("smt"))
                cpuData.setSmt(Boolean.parseBoolean(body.get("smt")));

            return cpuRepo.save(cpuData);
        } else {
            throw new RuntimeException("CPU not found with id " + id);
        }
    }
}
