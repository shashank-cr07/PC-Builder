package com.example.demo.services;

import com.example.demo.bases.*;
import com.example.demo.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private pc_repo pcRepository;

    @Autowired
    private cpu_repo cpuRepository;

    @Autowired
    private motherboard_repo motherboardRepository;

    @Autowired
    private memory_repo memoryRepository;

    @Autowired
    private video_card_repo videoCardRepository;

    @Autowired
    private power_supply_repo powerSupplyRepository;

    @Autowired
    private case_table_repo caseTableRepository;

    @Autowired
    private cpu_cooler_repo cpuCoolerRepository;

    @Autowired
    private internal_hard_drive_repo internalHardDriveRepository;

    @Autowired
    private external_hard_drive_repo externalHardDriveRepository;

    @Autowired
    private fan_controller_repo fanControllerRepository;

    @Autowired
    private case_fan_repo caseFanRepository;

    @Autowired
    private thermal_paste_repo thermalPasteRepository;

    @Autowired
    private os_repo osRepository;
    
    @Autowired
    private UserRepository userRepository;

    public String savePcBuild_user(Pc pc) {
        // Fetch and set CPU
        pc.setName(pc.getName());
        
        if (pc.getCpu() != null && pc.getCpu().getId() != null) {
            pc.setCpu(cpuRepository.findById(pc.getCpu().getId()).orElse(null));
        }
        if (pc.getUser() != null && pc.getUser().getId() != null) {
            pc.setUser(userRepository.findById(pc.getUser().getId()).orElse(null));
        }
        // Fetch and set Motherboard
        if (pc.getMotherboard() != null && pc.getMotherboard().getId() != null) {
            pc.setMotherboard(motherboardRepository.findById(pc.getMotherboard().getId()).orElse(null));
        }

        // Fetch and set Memory
        if (pc.getMemory() != null && pc.getMemory().getId() != null) {
            pc.setMemory(memoryRepository.findById(pc.getMemory().getId()).orElse(null));
        }

        // Fetch and set Video Card
        if (pc.getVideoCard() != null && pc.getVideoCard().getId() != null) {
            pc.setVideoCard(videoCardRepository.findById(pc.getVideoCard().getId()).orElse(null));
        }

        // Fetch and set Power Supply
        if (pc.getPowerSupply() != null && pc.getPowerSupply().getId() != null) {
            pc.setPowerSupply(powerSupplyRepository.findById(pc.getPowerSupply().getId()).orElse(null));
        }

        // Fetch and set Case
        if (pc.getCaseTable() != null && pc.getCaseTable().getId() != null) {
            pc.setCaseTable(caseTableRepository.findById(pc.getCaseTable().getId()).orElse(null));
        }

        // Fetch and set CPU Cooler
        if (pc.getCpuCooler() != null && pc.getCpuCooler().getId() != null) {
            pc.setCpuCooler(cpuCoolerRepository.findById(pc.getCpuCooler().getId()).orElse(null));
        }

        // Fetch and set Internal Hard Drive
        if (pc.getInternalHardDrive() != null && pc.getInternalHardDrive().getId() != null) {
            pc.setInternalHardDrive(internalHardDriveRepository.findById(pc.getInternalHardDrive().getId()).orElse(null));
        }

        // Fetch and set External Hard Drive
        if (pc.getExternalHardDrive() != null && pc.getExternalHardDrive().getId() != null) {
            pc.setExternalHardDrive(externalHardDriveRepository.findById(pc.getExternalHardDrive().getId()).orElse(null));
        }

        // Fetch and set Fan Controller
        if (pc.getFanController() != null && pc.getFanController().getId() != null) {
            pc.setFanController(fanControllerRepository.findById(pc.getFanController().getId()).orElse(null));
        }

        // Fetch and set Case Fan
        if (pc.getCaseFan() != null && pc.getCaseFan().getId() != null) {
            pc.setCaseFan(caseFanRepository.findById(pc.getCaseFan().getId()).orElse(null));
        }

        // Fetch and set Thermal Paste
        if (pc.getThermalPaste() != null && pc.getThermalPaste().getId() != null) {
            pc.setThermalPaste(thermalPasteRepository.findById(pc.getThermalPaste().getId()).orElse(null));
        }

        // Fetch and set OS
        if (pc.getOs() != null && pc.getOs().getId() != null) {
            pc.setOs(osRepository.findById(pc.getOs().getId()).orElse(null));
        }

        pcRepository.save(pc);
        return "PC build saved successfully.";
    }
}