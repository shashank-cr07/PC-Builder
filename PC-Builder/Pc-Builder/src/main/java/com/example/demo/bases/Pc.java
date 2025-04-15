package com.example.demo.bases;
import org.springframework.stereotype.Component;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

// Optional: Use @Builder from Lombok or build your own
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Component
public class Pc {
    
        @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne
    @JoinColumn(name = "cpu_id")
    private cpu cpu;

    @OneToOne
    @JoinColumn(name = "motherboard_id")
    private motherboard motherboard;

    @OneToOne
    @JoinColumn(name = "memory_id")
    private memory memory;

    @OneToOne
    @JoinColumn(name = "video_card_id")
    private video_card videoCard;

    @OneToOne
    @JoinColumn(name = "power_supply_id")
    private power_supply powerSupply;

    @OneToOne
    @JoinColumn(name = "case_table_id")
    private case_table caseTable;

    @OneToOne
    @JoinColumn(name = "cpu_cooler_id")
    private cpu_cooler cpuCooler;

    @OneToOne
    @JoinColumn(name = "internal_hard_drive_id")
    private internal_hard_drive internalHardDrive;

    @OneToOne
    @JoinColumn(name = "external_hard_drive_id")
    private external_hard_drive externalHardDrive;

    @OneToOne
    @JoinColumn(name = "fan_controller_id")
    private fan_controller fanController;

    @OneToOne
    @JoinColumn(name = "case_fan_id")
    private case_fan caseFan;

    @OneToOne
    @JoinColumn(name = "thermal_paste_id")
    private thermal_paste thermalPaste;

    @OneToOne
    @JoinColumn(name = "os_id")
    private os os;


    // Builder inner class (manual)
    public static class Builder {
        private Integer id;
        private cpu cpu;
        private motherboard motherboard;
        private memory memory;
        private video_card videoCard;
        private power_supply powerSupply;
        private case_table caseTable;
        private cpu_cooler cpuCooler;
        private internal_hard_drive internalHardDrive;
        private external_hard_drive externalHardDrive;
        private fan_controller fanController;
        
        private case_fan caseFan;
        private thermal_paste thermalPaste;
        private os os;

        public Builder cpu(cpu cpu) {
            this.cpu = cpu;
            return this;
        }

        public Builder motherboard(motherboard motherboard) {
            this.motherboard = motherboard;
            return this;
        }

        public Builder memory(memory memory) {
            this.memory = memory;
            return this;
        }

        public Builder videoCard(video_card videoCard) {
            this.videoCard = videoCard;
            return this;
        }

        public Builder powerSupply(power_supply powerSupply) {
            this.powerSupply = powerSupply;
            return this;
        }

        public Builder caseTable(case_table caseTable) {
            this.caseTable = caseTable;
            return this;
        }

        public Builder cpuCooler(cpu_cooler cpuCooler) {
            this.cpuCooler = cpuCooler;
            return this;
        }

        public Builder internalHardDrive(internal_hard_drive internalHardDrive) {
            this.internalHardDrive = internalHardDrive;
            return this;
        }

        public Builder externalHardDrive(external_hard_drive externalHardDrive) {
            this.externalHardDrive = externalHardDrive;
            return this;
        }

        public Builder fanController(fan_controller fanController) {
            this.fanController = fanController;
            return this;
        }

        public Builder caseFan(case_fan caseFan) {
            this.caseFan = caseFan;
            return this;
        }

        public Builder thermalPaste(thermal_paste thermalPaste) {
            this.thermalPaste = thermalPaste;
            return this;
        }

        public Builder os(os os) {
            this.os = os;
            return this;
        }

        public Pc build() {
            return new Pc(id, cpu, motherboard, memory, videoCard, powerSupply, caseTable,
                    cpuCooler, internalHardDrive, externalHardDrive, fanController,
                    caseFan, thermalPaste, os);
        }
    }

    //Getters 
    public Integer getCpuTdp() {
        return cpu != null ? cpu.getTdp() : 0;
    }

    public Integer getCpuCoreCount() {
        return cpu != null ? cpu.getCoreCount() : 0;
    }

    public String getMemoryModuleCount() {
        return memory != null ? memory.getModules() : " ";
    }

    public Integer getMotherboardMemorySlots() {
        return motherboard != null ? motherboard.getMemorySlots() : 0;
    }

    public Integer getMotherboardMaxMemory() {
        return motherboard != null ? motherboard.getMaxMemory() : 0;
    }

    public Integer getOsMaxMemory() {
        return os != null ? os.getMaxMemory() : 0;
    }

    public Integer getPowerSupplyWattage() {
        return powerSupply != null ? powerSupply.getWattage() : 0;
    }

    public String getPowerSupplyEfficiency() {
        return powerSupply != null ? powerSupply.getEfficiency() : "";
    }

    public Integer getGpuLength() {
        return videoCard != null ? videoCard.getLength() : 0;
    }

    public BigDecimal getCaseExternalVolume() {
        return caseTable != null ? caseTable.getExternalVolume() : BigDecimal.ZERO;
    }

    public Integer getFanControllerChannels() {
        return fanController != null ? fanController.getChannels() : 0;
    }

    public BigDecimal getFanControllerChannelWattage() {
        return fanController != null ? fanController.getChannelWattage() : BigDecimal.ZERO;
    }

    public String getCaseFanRpm() {
        return caseFan != null ? caseFan.getRpm() : "";
    }

    public String getCpuCoolerRpm() {
        return cpuCooler != null ? cpuCooler.getRpm() : "";
    }

    public BigDecimal getInternalDriveCapacity() {
        return internalHardDrive != null ? internalHardDrive.getCapacity() : BigDecimal.ZERO;
    }

    public Integer getExternalDriveCapacity() {
        return externalHardDrive != null ? externalHardDrive.getCapacity() : 0;
    }

    public String getCaseType() {
        return caseTable != null ? caseTable.getType() : "";
    }

    public String getMotherboardFormFactor() {
        return motherboard != null ? motherboard.getFormFactor() : "";
    }

    public String getCpuGraphics() {
        return cpu != null ? cpu.getGraphics() : "";
    }

    public String getPsuType() {
        return powerSupply != null ? powerSupply.getType() : "";
    }
}
