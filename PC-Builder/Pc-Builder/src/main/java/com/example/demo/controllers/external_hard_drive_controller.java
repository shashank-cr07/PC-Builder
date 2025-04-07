package com.example.demo.controllers;

import com.example.demo.bases.external_hard_drive;
import com.example.demo.repositories.external_hard_drive_repo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/external-hard-drive")
public class external_hard_drive_controller {

    @Autowired
    private external_hard_drive_repo externalHardDriveRepo;

    @GetMapping
    public List<external_hard_drive> getAllDrives() {
        return externalHardDriveRepo.findAll();
    }

    @GetMapping("/{id}")
    public external_hard_drive getDriveById(@PathVariable("id") Integer id) {
        return externalHardDriveRepo.findById(id).orElse(null);
    }

    @DeleteMapping("/remove/{id}")
    public boolean deleteDrive(@PathVariable("id") Integer id) {
        if (externalHardDriveRepo.existsById(id)) {
            externalHardDriveRepo.deleteById(id);
            return true;
        }
        return false;
    }

    @PostMapping("/add")
    public external_hard_drive addDrive(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String type = body.get("type");
            String interfaceType = body.get("interface");
            Integer capacity = Integer.parseInt(body.get("capacity"));
            BigDecimal pricePerGb = new BigDecimal(body.get("price_per_gb"));
            String color = body.get("color");

            external_hard_drive drive = new external_hard_drive(name, price, type, interfaceType, capacity, pricePerGb, color);
            return externalHardDriveRepo.save(drive);
        } catch (Exception e) {
            throw new RuntimeException("Error adding external hard drive", e);
        }
    }

    @PutMapping("/update/{id}")
    public external_hard_drive updateDrive(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<external_hard_drive> optDrive = externalHardDriveRepo.findById(id);
        if (optDrive.isPresent()) {
            external_hard_drive drive = optDrive.get();

            if (body.containsKey("name"))
                drive.setName(body.get("name"));

            if (body.containsKey("price"))
                drive.setPrice(new BigDecimal(body.get("price")));

            if (body.containsKey("type"))
                drive.setType(body.get("type"));

            if (body.containsKey("interface"))
                drive.setInterfaceType(body.get("interface"));

            if (body.containsKey("capacity"))
                drive.setCapacity(Integer.parseInt(body.get("capacity")));

            if (body.containsKey("price_per_gb"))
                drive.setPricePerGb(new BigDecimal(body.get("price_per_gb")));

            if (body.containsKey("color"))
                drive.setColor(body.get("color"));

            return externalHardDriveRepo.save(drive);
        } else {
            throw new RuntimeException("External Hard Drive not found with id " + id);
        }
    }
}
