package com.example.demo.controllers;

import com.example.demo.bases.*;
import com.example.demo.bases.Pc.Builder;
import com.example.demo.repositories.*;
import com.example.demo.services.ScoreService;

import java.util.Map;
import java.util.Optional;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/score")
public class score_controller {

    @Autowired
    private ScoreService scoreService;

    @Autowired
    private cpu_repo cpuRepo;
    @Autowired
    private motherboard_repo motherboardRepo;
    @Autowired
    private memory_repo memoryRepo;
    @Autowired
    private video_card_repo videoCardRepo;
    @Autowired
    private power_supply_repo powerSupplyRepo;
    @Autowired
    private case_table_repo caseTableRepo;
    @Autowired
    private cpu_cooler_repo cpuCoolerRepo;
    @Autowired
    private internal_hard_drive_repo internalHardDriveRepo;
    @Autowired
    private external_hard_drive_repo externalHardDriveRepo;
    @Autowired
    private fan_controller_repo fanControllerRepo;
    @Autowired
    private case_fan_repo caseFanRepo;
    @Autowired
    private thermal_paste_repo thermalPasteRepo;
    @Autowired
    private os_repo osRepo;
    @Autowired
    private UserRepository userRepo;
    @Autowired
    private pc_repo pcRepo;

    @PostMapping("/total")
    public int[] getTotalScore(@RequestBody Pc pc) {
        // Print specific fields
        if (pc.getCpu() != null && pc.getCpu().getId() != null) {
            cpu cpu = cpuRepo.findById(pc.getCpu().getId()).orElse(null);
            if (cpu != null) {
                pc.setCpu(cpu); // Set the fetched CPU in the Pc object
            } else {
                System.out.println("CPU not found");
            }
        }
        // Fetch Motherboard by its ID
        if (pc.getMotherboard() != null && pc.getMotherboard().getId() != null) {
            motherboard motherboard = motherboardRepo.findById(pc.getMotherboard().getId()).orElse(null);
            if (motherboard != null) {
                pc.setMotherboard(motherboard); // Set the fetched Motherboard in the Pc object
            } else {
                System.out.println("Motherboard not found");
            }
        }

        // Fetch Memory by its ID
        if (pc.getMemory() != null && pc.getMemory().getId() != null) {
            memory memory = memoryRepo.findById(pc.getMemory().getId()).orElse(null);
            if (memory != null) {
                pc.setMemory(memory); // Set the fetched Memory in the Pc object
            } else {
                System.out.println("Memory not found");
            }
        }

        // Fetch VideoCard by its ID
        if (pc.getVideoCard() != null && pc.getVideoCard().getId() != null) {
            video_card videoCard = videoCardRepo.findById(pc.getVideoCard().getId()).orElse(null);
            if (videoCard != null) {
                pc.setVideoCard(videoCard); // Set the fetched VideoCard in the Pc object
            } else {
                System.out.println("Video Card not found");
            }
        }

        // Fetch PowerSupply by its ID
        if (pc.getPowerSupply() != null && pc.getPowerSupply().getId() != null) {
            power_supply powerSupply = powerSupplyRepo.findById(pc.getPowerSupply().getId()).orElse(null);
            if (powerSupply != null) {
                pc.setPowerSupply(powerSupply); // Set the fetched PowerSupply in the Pc object
            } else {
                System.out.println("Power Supply not found");
            }
        }

        // Fetch Case by its ID
        if (pc.getCaseTable() != null && pc.getCaseTable().getId() != null) {
            case_table caseTable = caseTableRepo.findById(pc.getCaseTable().getId()).orElse(null);
            if (caseTable != null) {
                pc.setCaseTable(caseTable); // Set the fetched Case in the Pc object
            } else {
                System.out.println("Case not found");
            }
        }

        // Fetch CPU Cooler by its ID
        if (pc.getCpuCooler() != null && pc.getCpuCooler().getId() != null) {
            cpu_cooler cpuCooler = cpuCoolerRepo.findById(pc.getCpuCooler().getId()).orElse(null);
            if (cpuCooler != null) {
                pc.setCpuCooler(cpuCooler); // Set the fetched CPU Cooler in the Pc object
            } else {
                System.out.println("CPU Cooler not found");
            }
        }

        // Fetch Internal Hard Drive by its ID
        if (pc.getInternalHardDrive() != null && pc.getInternalHardDrive().getId() != null) {
            internal_hard_drive internalHardDrive = internalHardDriveRepo.findById(pc.getInternalHardDrive().getId())
                    .orElse(null);
            if (internalHardDrive != null) {
                pc.setInternalHardDrive(internalHardDrive); // Set the fetched Internal Hard Drive in the Pc object
            } else {
                System.out.println("Internal Hard Drive not found");
            }
        }

        // Fetch External Hard Drive by its ID
        if (pc.getExternalHardDrive() != null && pc.getExternalHardDrive().getId() != null) {
            external_hard_drive externalHardDrive = externalHardDriveRepo.findById(pc.getExternalHardDrive().getId())
                    .orElse(null);
            if (externalHardDrive != null) {
                pc.setExternalHardDrive(externalHardDrive); // Set the fetched External Hard Drive in the Pc object
            } else {
                System.out.println("External Hard Drive not found");
            }
        }

        // Fetch Fan Controller by its ID
        if (pc.getFanController() != null && pc.getFanController().getId() != null) {
            fan_controller fanController = fanControllerRepo.findById(pc.getFanController().getId()).orElse(null);
            if (fanController != null) {
                pc.setFanController(fanController); // Set the fetched Fan Controller in the Pc object
            } else {
                System.out.println("Fan Controller not found");
            }
        }

        // Fetch Case Fan by its ID
        if (pc.getCaseFan() != null && pc.getCaseFan().getId() != null) {
            case_fan caseFan = caseFanRepo.findById(pc.getCaseFan().getId()).orElse(null);
            if (caseFan != null) {
                pc.setCaseFan(caseFan); // Set the fetched Case Fan in the Pc object
            } else {
                System.out.println("Case Fan not found");
            }
        }

        // Fetch Thermal Paste by its ID
        if (pc.getThermalPaste() != null && pc.getThermalPaste().getId() != null) {
            thermal_paste thermalPaste = thermalPasteRepo.findById(pc.getThermalPaste().getId()).orElse(null);
            if (thermalPaste != null) {
                pc.setThermalPaste(thermalPaste); // Set the fetched Thermal Paste in the Pc object
            } else {
                System.out.println("Thermal Paste not found");
            }
        }

        // Fetch OS by its ID
        if (pc.getOs() != null && pc.getOs().getId() != null) {
            os os = osRepo.findById(pc.getOs().getId()).orElse(null);
            if (os != null) {
                pc.setOs(os); // Set the fetched OS in the Pc object
            } else {
                System.out.println("OS not found");
            }
        }
        System.out.println(
                "CPU: " + pc.getCpu().getCoreCount() + " " + pc.getCpu().getBoostClock() + " " + pc.getCpu().getTdp());
        System.out.println("Motherboard: " + pc.getMotherboard().getMemorySlots() + " "
                + pc.getMotherboard().getMaxMemory() + " " + pc.getMotherboard().getFormFactor());
        System.out.println("Memory: " + pc.getMemory().getModules() + " " + pc.getMemory().getSpeed());
        System.out.println("Video Card: " + pc.getVideoCard().getMemory() + " " + pc.getVideoCard().getBoost_clock());
        System.out.println("Power Supply: " + pc.getPowerSupply().getWattage() + " " + pc.getPowerSupplyEfficiency());
        System.out.println("Case: " + pc.getCaseTable().getType());
        System.out.println("CPU Cooler: " + pc.getCpuCooler().getName());
        System.out.println("Internal Hard Drive: " + pc.getInternalHardDrive().getType());
        System.out.println("External Hard Drive: " + pc.getExternalHardDrive().getType());
        System.out.println("Fan Controller: " + pc.getFanController());
        System.out.println("Case Fan: " + pc.getCaseFan());
        System.out.println("Thermal Paste: " + pc.getThermalPaste());
        System.out.println("OS: " + pc.getOs());

        // Call service method
        return scoreService.getTotalScore(pc);
    }

    @PostMapping("/compatibility")
    public int getCompatibilityScore(@RequestBody Pc pc) {
        return scoreService.calculateCompatibilityScore(pc);
    }

    @PostMapping("/performance")
    public int getPerformanceScore(@RequestBody Pc pc) {
        return scoreService.calculatePerformanceScore(pc);
    }

    @PostMapping("/reccomend")
    public Pc reccomend_PC(@RequestBody Map<String, Float> body) {
        float budget = body.get("budget");

        Pc.Builder builder = new Pc.Builder();
        cpu cpuObj = new cpu();
        video_card vc = new video_card();

        Integer user_id = body.get("user").intValue();
        User user_obj = userRepo.findById(user_id).orElse(null);
        builder.User(user_obj);

        Float cpuBudget = body.get("cpu") * budget;
        Integer cpuId = cpuRepo.get_best_cpu_id(cpuBudget);
        if (cpuId != null) {
            cpuObj = cpuRepo.findById(cpuId).orElse(null);
            if (cpuObj != null)
                builder.cpu(cpuObj);
        }

        Float memoryBudget = body.get("memory") * budget;
        Integer memoryId = memoryRepo.get_best_memory_id(memoryBudget);
        if (memoryId != null) {
            memory mem = memoryRepo.findById(memoryId).orElse(null);
            if (mem != null)
                builder.memory(mem);
        }

        Float gpuBudget = body.get("videoCard") * budget;
        Integer gpuId = videoCardRepo.get_best_video_card_id(gpuBudget);
        if (gpuId != null) {
            vc = videoCardRepo.findById(gpuId).orElse(null);
            if (vc != null)
                builder.videoCard(vc);
        }

        Float psuBudget = body.get("powerSupply") * budget;
        int exp_power = scoreService.estimateTotalPower(cpuObj, vc) + 150;
        Integer psuId = powerSupplyRepo.get_best_power_supply_id(psuBudget, exp_power);
        if (psuId != null) {
            power_supply psu = powerSupplyRepo.findById(psuId).orElse(null);
            if (psu != null)
                builder.powerSupply(psu);
        }

        Float coolerBudget = body.get("cpuCooler") * budget;
        Integer coolerId = cpuCoolerRepo.get_best_cpu_cooler_id(coolerBudget);
        if (coolerId != null) {
            cpu_cooler cc = cpuCoolerRepo.findById(coolerId).orElse(null);
            if (cc != null)
                builder.cpuCooler(cc);
        }

        Float internalHDBudget = body.get("internalHardDrive") * budget;
        Integer intHDId = internalHardDriveRepo.get_best_internal_drive_id(internalHDBudget);
        if (intHDId != null) {
            internal_hard_drive ihd = internalHardDriveRepo.findById(intHDId).orElse(null);
            if (ihd != null)
                builder.internalHardDrive(ihd);
        }

        Float externalHDBudget = body.get("externalHardDrive") * budget;
        Integer extHDId = externalHardDriveRepo.get_best_external_drive_id(externalHDBudget);
        if (extHDId != null) {
            external_hard_drive ehd = externalHardDriveRepo.findById(extHDId).orElse(null);
            if (ehd != null)
                builder.externalHardDrive(ehd);
        }

        Float motherboardBudget = body.get("motherboard") * budget;
        Integer mbId = motherboardRepo.get_best_motherboard_id(cpuId, memoryId, motherboardBudget);
        if (mbId != null) {
            motherboard mbObj = motherboardRepo.findById(mbId).orElse(null);
            if (mbObj != null)
                builder.motherboard(mbObj);
        }

        Float caseBudget = body.get("caseTable") * budget;
        Integer caseId = caseTableRepo.get_best_case_id(mbId, caseBudget);
        if (caseId != null) {
            case_table ct = caseTableRepo.findById(caseId).orElse(null);
            if (ct != null)
                builder.caseTable(ct);
        }

        Float fanControllerBudget = body.get("fanController") * budget;
        Integer fanCtrlId = fanControllerRepo.get_best_fan_controller_id(fanControllerBudget);
        if (fanCtrlId != null) {
            fan_controller fc = fanControllerRepo.findById(fanCtrlId).orElse(null);
            if (fc != null)
                builder.fanController(fc);
        }

        Float caseFanBudget = body.get("caseFan") * budget;
        Integer caseFanId = caseFanRepo.get_best_case_fan_id(caseFanBudget);
        if (caseFanId != null) {
            case_fan cf = caseFanRepo.findById(caseFanId).orElse(null);
            if (cf != null)
                builder.caseFan(cf);
        }

        Float pasteBudget = body.get("thermalPaste") * budget;
        Integer pasteId = thermalPasteRepo.get_best_thermal_paste_id(pasteBudget);
        if (pasteId != null) {
            thermal_paste tp = thermalPasteRepo.findById(pasteId).orElse(null);
            if (tp != null)
                builder.thermalPaste(tp);
        }

        Float osBudget = body.get("os") * budget;
        Integer osId = osRepo.get_best_os_id(osBudget);
        if (osId != null) {
            os osObj = osRepo.findById(osId).orElse(null);
            if (osObj != null)
                builder.os(osObj);
        }

        return builder.build();
    }

    private ResponseEntity<Map<String, Object>> notFoundResponse(String partName, Integer partId) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", partName + " not found with ID: " + partId));
    }

    @PostMapping("/add-part")
    public ResponseEntity<?> addPartToPc(
            @RequestParam(required = false) Integer pcId,
            @RequestBody Map<String, Object> request,
            HttpSession session) {

        try {
            // Get part type and ID from request
            String partType = (String) request.get("partType");
            Integer partId = (Integer) request.get("partId");

            if (partType == null) {
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "PartType needed"));
            }
            if (partId == null && pcId == null) {
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "cant remove from not given pc id"));
            }

            // Get or create PC build
            Pc pc;
            if (pcId == null) {
                // Create new PC build
                pc = new Pc.Builder().build();

            } else {
                // Get existing PC build
                long pcid_long = (long) pcId;
                Optional<Pc> pcOptional = pcRepo.findById(pcid_long);
                if (pcOptional.isEmpty()) {
                    return ResponseEntity.badRequest().body(Map.of(
                            "success", false,
                            "message", "PC build not found with id: " + pcId));
                }
                pc = pcOptional.get();
            }
            session.setAttribute("username", "shashank");
            String username = (String) session.getAttribute("username");
            System.out.println(username);
            User currentUser = userRepo.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // Create builder from existing PC
            Builder builder = new Builder().User(currentUser)
                    .cpu(pc.getCpu())
                    .motherboard(pc.getMotherboard())
                    .memory(pc.getMemory())
                    .videoCard(pc.getVideoCard())
                    .powerSupply(pc.getPowerSupply())
                    .caseTable(pc.getCaseTable())
                    .cpuCooler(pc.getCpuCooler())
                    .internalHardDrive(pc.getInternalHardDrive())
                    .externalHardDrive(pc.getExternalHardDrive())
                    .fanController(pc.getFanController())
                    .caseFan(pc.getCaseFan())
                    .thermalPaste(pc.getThermalPaste())
                    .os(pc.getOs());
            System.out.println("HI");
            System.out.println(partId);
            if (partId == null) {
                switch (partType.toLowerCase()) {
                    case "cpu":
                        builder.cpu(null);
                        break;
                    case "video_card":
                        builder.videoCard(null);
                        break;
                    case "motherboard":
                        builder.motherboard(null);
                        break;
                    case "memory":
                        builder.memory(null);
                        break;
                    case "power_supply":
                        builder.powerSupply(null);
                        break;
                    case "case_table":
                        builder.caseTable(null);
                        break;
                    case "cpu_cooler":
                        builder.cpuCooler(null);
                        break;
                    case "internal_hard_drive":
                        builder.internalHardDrive(null);
                        break;
                    case "external_hard_drive":
                        builder.externalHardDrive(null);
                        break;
                    case "fan_controller":
                        builder.fanController(null);
                        break;
                    case "case_fan":
                        builder.caseFan(null);
                        break;
                    case "thermal_paste":
                        builder.thermalPaste(null);
                        break;
                    case "os":
                        builder.os(null);
                        break;
                    default:
                        return ResponseEntity.badRequest().body(Map.of(
                                "success", false,
                                "message", "Unknown part type: " + partType));
                }
            } else {
                // Add the specified part
                switch (partType.toLowerCase()) {
                    case "cpu":
                        cpu cpuOpt = cpuRepo.findById(partId).orElse(null);
                        System.out.println(cpuOpt);
                        if (cpuOpt == null) {
                            builder.cpu(null);
                        } else
                            builder.cpu(cpuOpt);
                        break;

                    case "video_card":
                        Optional<video_card> videoCardOpt = videoCardRepo.findById(partId);
                        if (videoCardOpt.isEmpty()) {
                            return notFoundResponse("Video Card", partId);
                        }
                        builder.videoCard(videoCardOpt.get());
                        break;

                    case "motherboard":
                        Optional<motherboard> mbOpt = motherboardRepo.findById(partId);
                        if (mbOpt.isEmpty()) {
                            return notFoundResponse("Motherboard", partId);
                        }
                        builder.motherboard(mbOpt.get());
                        break;

                    case "memory":
                        Optional<memory> memoryOpt = memoryRepo.findById(partId);
                        if (memoryOpt.isEmpty()) {
                            return notFoundResponse("Memory", partId);
                        }
                        builder.memory(memoryOpt.get());
                        break;

                    case "power_supply":
                        Optional<power_supply> psuOpt = powerSupplyRepo.findById(partId);
                        if (psuOpt.isEmpty()) {
                            return notFoundResponse("Power Supply", partId);
                        }
                        builder.powerSupply(psuOpt.get());
                        break;

                    case "case_table": 
                        Optional<case_table> caseOpt = caseTableRepo.findById(partId);
                        if (caseOpt.isEmpty()) {
                            return notFoundResponse("Case", partId);
                        }
                        builder.caseTable(caseOpt.get());
                        break;

                    case "cpu_cooler":
                        Optional<cpu_cooler> coolerOpt = cpuCoolerRepo.findById(partId);
                        if (coolerOpt.isEmpty()) {
                            return notFoundResponse("CPU Cooler", partId);
                        }
                        builder.cpuCooler(coolerOpt.get());
                        break;

                    case "internal_hard_drive":
                        Optional<internal_hard_drive> intHdOpt = internalHardDriveRepo.findById(partId);
                        if (intHdOpt.isEmpty()) {
                            return notFoundResponse("Internal Hard Drive", partId);
                        }
                        builder.internalHardDrive(intHdOpt.get());
                        break;

                    case "external_hard_drive":
                        Optional<external_hard_drive> extHdOpt = externalHardDriveRepo.findById(partId);
                        if (extHdOpt.isEmpty()) {
                            return notFoundResponse("External Hard Drive", partId);
                        }
                        builder.externalHardDrive(extHdOpt.get());
                        break;

                    case "fan_controller":
                        Optional<fan_controller> fanCtrlOpt = fanControllerRepo.findById(partId);
                        if (fanCtrlOpt.isEmpty()) {
                            return notFoundResponse("Fan Controller", partId);
                        }
                        builder.fanController(fanCtrlOpt.get());
                        break;

                    case "case_fan":
                        Optional<case_fan> caseFanOpt = caseFanRepo.findById(partId);
                        if (caseFanOpt.isEmpty()) {
                            return notFoundResponse("Case Fan", partId);
                        }
                        builder.caseFan(caseFanOpt.get());
                        break;

                    case "thermal_paste":
                        Optional<thermal_paste> pasteOpt = thermalPasteRepo.findById(partId);
                        if (pasteOpt.isEmpty()) {
                            return notFoundResponse("Thermal Paste", partId);
                        }
                        builder.thermalPaste(pasteOpt.get());
                        break;

                    case "os":
                        Optional<os> osOpt = osRepo.findById(partId);
                        if (osOpt.isEmpty()) {
                            return notFoundResponse("OS", partId);
                        }
                        builder.os(osOpt.get());
                        break;

                    default:
                        return ResponseEntity.badRequest().body(Map.of(
                                "success", false,
                                "message", "Unknown part type: " + partType));
                }
            }
            // Build and save the updated PC
            pc = builder.build();
            pc.setId(pcId);
            System.out.println(pc.getId());
            pcRepo.save(pc);

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", partType + " added successfully",
                    "pcId", pc.getId()));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                    "success", false,
                    "message", "Error adding part: " + e.getMessage()));
        }
    }

    @PostMapping("/add-name")
    public ResponseEntity<String> addPcName(
            @RequestParam("pcId") Long pcId,
            @RequestBody Map<String, String> body) {

        String partType = body.get("partType");
        String partId = body.get("partId"); // This will be the name, like "monster build"

        if (!"name".equalsIgnoreCase(partType)) {
            return ResponseEntity.badRequest().body("Invalid partType. Expected 'name'");
        }

        Optional<Pc> pcOpt = pcRepo.findById(pcId);
        if (pcOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("PC not found");
        }

        Pc pc = pcOpt.get();
        pc.setName(partId);  // Assuming your Pc entity has a 'name' field
        pcRepo.save(pc);

        return ResponseEntity.ok("Name updated successfully");
    }
}
