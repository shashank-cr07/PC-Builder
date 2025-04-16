package com.example.demo.services;

import com.example.demo.bases.Pc;
import java.util.ArrayList;
import java.util.List;

public class PcCompatibilityService {

    public List<String> checkCompatibility(Pc pc) {
        List<String> issues = new ArrayList<>();

        // No socket field, so this check is skipped or replaced with a note
        if (pc.getCpu() == null || pc.getMotherboard() == null) {
            issues.add("Missing CPU or Motherboard.");
        }

        // Memory slots vs modules
        if (pc.getMemory() != null && pc.getMotherboard() != null &&
            Integer.parseInt(pc.getMemory().getModules()) > pc.getMotherboard().getMemorySlots()) {
            issues.add("Not enough memory slots on motherboard.");
        }

        // Form factor (case_table.type vs motherboard.form_factor)
        if (pc.getCaseTable() != null && pc.getMotherboard() != null &&
            !pc.getCaseTable().getType().toLowerCase().contains(pc.getMotherboard().getFormFactor().toLowerCase())) {
            issues.add("Case type may not support motherboard form factor.");
        }

        // GPU length check (video_card.length vs assumed case_table.internal_35_bays as rough space)
        if (pc.getVideoCard() != null && pc.getCaseTable() != null &&
            pc.getVideoCard().getLength().compareTo(pc.getCaseTable().getInternal35Bays().intValue() * 25) > 0) {
            issues.add("GPU might not fit in the case.");
        }

        // Power supply wattage check
        if (pc.getPowerSupply() != null && pc.getCpu() != null &&
            pc.getPowerSupply().getWattage() < estimatePowerUsage(pc)) {
            issues.add("Power supply might be insufficient.");
        }

        return issues;
    }

    private int estimatePowerUsage(Pc pc) {
        int cpuTdp = (pc.getCpu() != null && pc.getCpu().getTdp() != null) ? pc.getCpu().getTdp() : 65;
        return cpuTdp + 250; // rough estimate with 250W for GPU + others
    }
}

