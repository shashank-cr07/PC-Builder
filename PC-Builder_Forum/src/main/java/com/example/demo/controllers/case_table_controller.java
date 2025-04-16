package com.example.demo.controllers;

import com.example.demo.bases.case_table;
import com.example.demo.repositories.case_table_repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/case-table")
public class case_table_controller {

    @Autowired
    private case_table_repo caseTableRepo;

    @GetMapping
    public List<case_table> getAllCases() {
        return caseTableRepo.findAll();
    }

    @GetMapping("/{id}")
    public case_table getCaseById(@PathVariable("id") Integer id) {
        return caseTableRepo.findById(id).orElse(null);
    }

    @DeleteMapping("/remove/{id}")
    public boolean deleteCase(@PathVariable("id") Integer id) {
        if (caseTableRepo.existsById(id)) {
            caseTableRepo.deleteById(id);
            return true;
        }
        return false;
    }

    @PutMapping("/update/{id}")
    public case_table updateCase(@PathVariable("id") Integer id, @RequestBody Map<String, String> body) {
        Optional<case_table> caseOpt = caseTableRepo.findById(id);
        if (caseOpt.isPresent()) {
            case_table caseData = caseOpt.get();

            if (body.containsKey("name"))
                caseData.setName(body.get("name"));

            if (body.containsKey("price"))
                caseData.setPrice(new BigDecimal(body.get("price")));

            if (body.containsKey("type"))
                caseData.setType(body.get("type"));

            if (body.containsKey("color"))
                caseData.setColor(body.get("color"));

            if (body.containsKey("psu"))
                caseData.setPsu(body.get("psu"));

            if (body.containsKey("sidePanel"))
                caseData.setSidePanel(body.get("sidePanel"));

            if (body.containsKey("externalVolume"))
                caseData.setExternalVolume(new BigDecimal(body.get("externalVolume")));

            if (body.containsKey("internal35Bays"))
                caseData.setInternal35Bays(Integer.parseInt(body.get("internal35Bays")));

            return caseTableRepo.save(caseData);
        } else {
            throw new RuntimeException("Case not found with id " + id);
        }
    }


    @PostMapping("/add")
    public case_table createCase(@RequestBody Map<String, String> body) {
        try {
            String name = body.get("name");
            BigDecimal price = new BigDecimal(body.get("price"));
            String type = body.get("type");
            String color = body.get("color");
            String psu = body.get("psu");
            String sidePanel = body.get("sidePanel");
            BigDecimal externalVolume = new BigDecimal(body.get("externalVolume"));
            Integer internal35Bays = Integer.parseInt(body.get("internal35Bays"));

            case_table newCase = new case_table(name, price, type, color, psu, sidePanel, externalVolume, internal35Bays);
            return caseTableRepo.save(newCase);
        } catch (Exception e) {
            throw new RuntimeException("Error creating Case", e);
        }
    }
}
