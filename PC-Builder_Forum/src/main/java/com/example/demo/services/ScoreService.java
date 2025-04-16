package com.example.demo.services;

import com.example.demo.bases.Pc;
import com.example.demo.bases.cpu;
import com.example.demo.bases.video_card;

import org.springframework.stereotype.Service;

@Service
public class ScoreService {

    public int calculateCompatibilityScore(Pc pc) {
        int score = 0;
        int totalPossibleScore = 40; // Total possible compatibility points
        
        try {
            // 1. CPU and Motherboard socket compatibility
            if (pc.getCpu() != null && pc.getMotherboard() != null && 
                pc.getMotherboard().getSocket() != null) {
                // Since we don't have CPU socket in database, we can only check if motherboard has a socket defined
                if (pc.getMotherboard().getSocket() != null && !pc.getMotherboard().getSocket().isEmpty()) {
                    score += 10; // At least it has a socket defined
                }
            }
            
            // 2. RAM module count vs. motherboard slots
            if (pc.getMemory() != null && pc.getMemory().getModules() != null && 
                pc.getMotherboard() != null && pc.getMotherboard().getMemorySlots() != null) {
                String modulesStr = pc.getMemory().getModules().toLowerCase().trim(); // e.g., "2x16"
                try {
                    String[] parts = modulesStr.split("x");
                    if (parts.length >= 1) {
                        int moduleCount = Integer.parseInt(parts[0].trim());
                        
                        if (moduleCount <= pc.getMotherboard().getMemorySlots()) {
                            score += 10;
                        }
                    }
                } catch (NumberFormatException e) {
                    // Invalid format handling
                }
            }
            
            // 3. RAM capacity vs. motherboard max memory
            if (pc.getMemory() != null && pc.getMemory().getModules() != null && 
                pc.getMotherboard() != null && pc.getMotherboard().getMaxMemory() != null) {
                String modulesStr = pc.getMemory().getModules().toLowerCase().trim(); // e.g., "2x16"
                try {
                    String[] parts = modulesStr.split("x");
                    if (parts.length >= 2) {
                        int moduleCount = Integer.parseInt(parts[0].trim());
                        int moduleSize = Integer.parseInt(parts[1].trim());
                        int totalRam = moduleCount * moduleSize;
                        
                        if (totalRam <= pc.getMotherboard().getMaxMemory()) {
                            score += 5;
                        }
                    }
                } catch (NumberFormatException e) {
                    // Invalid format handling
                }
            }

            // 4. Power supply sufficiency check
            if (pc.getPowerSupply() != null && pc.getPowerSupply().getWattage() != null) {
                int estimated = estimateTotalPower(pc);
                if (pc.getPowerSupply().getWattage() >= estimated + 100) {
                    score += 5;
                }
                if (pc.getPowerSupply().getWattage() >= estimated + 200) {
                    score += 5; // Additional buffer is better
                }
            }

            // 5. Case and motherboard form factor compatibility
            if (pc.getCaseTable() != null && pc.getCaseTable().getType() != null &&
                pc.getMotherboard() != null && pc.getMotherboard().getFormFactor() != null) {
                
                String caseType = pc.getCaseTable().getType().toLowerCase();
                String moboFormFactor = pc.getMotherboard().getFormFactor().toLowerCase();
                
                // Check if case supports motherboard form factor
                // Full Tower and Mid Tower cases typically support all form factors
                // Smaller cases have more restrictions
                if ((caseType.contains("full") || caseType.contains("mid")) && 
                    (moboFormFactor.contains("atx") || moboFormFactor.contains("micro") || 
                     moboFormFactor.contains("mini"))) {
                    score += 5;
                } else if (caseType.contains("micro") && 
                          (moboFormFactor.contains("micro") || moboFormFactor.contains("mini"))) {
                    score += 5;
                } else if (caseType.contains("mini") && moboFormFactor.contains("mini")) {
                    score += 5;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Normalize score to a 0-100 scale
        return (int)((double)score / totalPossibleScore * 100);
    }

    public int calculatePerformanceScore(Pc pc) {
        int score = 0;

        try {
            // 1. CPU Performance (up to 30 points)
            if (pc.getCpu() != null) {
                // Core count (up to 12 points)
                if (pc.getCpu().getCoreCount() != null) {
                    score += pc.getCpu().getCoreCount()/64 *12;
                }
                
                // Clock speeds (up to 10 points)
                if (pc.getCpu().getBoostClock() != null) {
                    // Scale boost clock: 3.5GHz = 5pts, 5.0GHz = 10pts
                    double boostPoints = (pc.getCpu().getBoostClock().doubleValue() - 2.0) * 3.33;
                    score += Math.min(Math.max(0, (int)boostPoints), 10);
                } else if (pc.getCpu().getCoreClock() != null) {
                    // Fall back to core clock if boost isn't available
                    double clockPoints = (pc.getCpu().getCoreClock().doubleValue() - 1.5) * 3.33;
                    score += Math.min(Math.max(0, (int)clockPoints), 8);
                }
                
                // SMT/Hyperthreading bonus (3 points)
                if (pc.getCpu().getSmt() != null && pc.getCpu().getSmt()) {
                    score += 3;
                }
                
                // Integrated graphics bonus (2 points if present)
                if (pc.getCpu().getGraphics() != null && !pc.getCpu().getGraphics().equalsIgnoreCase("None")) {
                    score += 2;
                }
                
                // TDP efficiency (up to 3 points)
                if (pc.getCpu().getTdp() != null && pc.getCpu().getCoreCount() != null) {
                    double tdpPerCore = (double)pc.getCpu().getTdp() / pc.getCpu().getCoreCount();
                    if (tdpPerCore < 10) score += 3;
                    else if (tdpPerCore < 15) score += 2;
                    else if (tdpPerCore < 20) score += 1;
                }
            }
            System.out.println("CPU SCORE: "+score);
            // 2. GPU Performance (up to 30 points)
            // Assuming pc.getVideoCard() returns a VideoCard object with relevant methods
            if (pc.getVideoCard() != null) {
                video_card vc = pc.getVideoCard();
            
            // 1. Memory capacity (up to 10 points)
            if (vc.getMemory() != null) {
                int memory = vc.getMemory().intValue();
                if (memory >= 24) {
                    score += 10;
                } else if (memory >= 16) {
                    score += 9;
                } else if (memory >= 12) {
                    score += 8;
                } else if (memory >= 8) {
                    score += 6;
                } else if (memory >= 6) {
                    score += 5;
                } else if (memory >= 4) {
                    score += 4;
                } else if (memory >= 2) {
                    score += 3;
                } else {
                    score += 1;
                }
            }

        // 2. Boost clock speed (up to 10 points)
        if (vc.getBoost_clock() != null) {
            double boostClock = vc.getBoost_clock().doubleValue();
            if (boostClock >= 2500) {
                score += 10;
            } else if (boostClock >= 2000) {
                score += 8;
            } else if (boostClock >= 1700) {
                score += 6;
            } else if (boostClock >= 1500) {
                score += 4;
            } else if (boostClock >= 1300) {
                score += 3;
            } else {
                score += 1;
            }
        }

        // 3. Core clock speed (up to 6 points)
        if (vc.getCore_clock() != null) {
            double coreClock = vc.getCore_clock().doubleValue();
            if (coreClock >= 2000) {
                score += 6;
            } else if (coreClock >= 1600) {
                score += 5;
            } else if (coreClock >= 1300) {
                score += 4;
            } else if (coreClock >= 1000) {
                score += 3;
            } else {
                score += 1;
            }
        }

        // 4. Architecture/Generation Score (up to 10 points)
        if (vc.getChipset() != null) {
            String chipset = vc.getChipset().toLowerCase();
        
            // NVIDIA Consumer GPUs Scoring
            if (chipset.contains("4090")) {
                score += 10;
            } else if (chipset.contains("4080")) {
                score += 9;
            } else if (chipset.contains("3090")) {
                score += 8;
            } else if (chipset.contains("3080")) {
                score += 7;
            } else if (chipset.contains("2080")) {
                score += 6;
            } else if (chipset.contains("1080")) {
                score += 5;
            } else if (chipset.contains("1060")) {
                score += 4;
        
            // NVIDIA Professional GPUs Scoring (RTX, Quadro, etc.)
            } else if (chipset.contains("rtx a6000")) {
                score += 12; // High-end professional GPU
            } else if (chipset.contains("rtx 6000 ada")) {
                score += 12; // High-end professional GPU
            } else if (chipset.contains("quadro rtx 8000")) {
                score += 11; // High-end professional GPU
            } else if (chipset.contains("quadro rtx 6000")) {
                score += 10; // High-end professional GPU
            } else if (chipset.contains("rtx a5000")) {
                score += 9; // Mid-range professional GPU
            } else if (chipset.contains("rtx 4000")) {
                score += 8; // Mid-range professional GPU
        
            // AMD Radeon GPUs Scoring
            } else if (chipset.contains("rx 6900")) {
                score += 10;
            } else if (chipset.contains("rx 6800")) {
                score += 9;
            } else if (chipset.contains("rx 5700")) {
                score += 8;
            } else if (chipset.contains("rx 5600")) {
                score += 7;
            } else if (chipset.contains("rx 5500")) {
                score += 6;
        
            // Older or less common GPUs (Generic scoring)
            } else if (chipset.contains("rx") || chipset.contains("radeon")) {
                score += 4; // Older AMD Radeon GPUs
            } else if (chipset.contains("gtx") || chipset.contains("gt")) {
                score += 3; // Older NVIDIA GTX models
            } else if (chipset.contains("integrated")) {
                score += 2; // Integrated graphics (like Intel UHD)
            } else {
                score += 1; // Unknown or less-known GPUs
            }
        }
        

        // Now `score` contains the calculated performance score
        System.out.println("Video Card Performance Score: " + score);
    }

            // 3. RAM Performance (up to 15 points)
            if (pc.getMemory() != null) {
                // Speed (up to 8 points)
                if (pc.getMemory().getSpeed() != null) {
                    String speedString = pc.getMemory().getSpeed().replace(",", "");
                    try {
                        int memSpeed = Integer.parseInt(speedString);
                        score += Math.min(memSpeed / 400, 8);
                    } catch (NumberFormatException e) {
                        // Handle exception
                    }
                }
                
                // Total capacity from modules (up to 7 points)
                if (pc.getMemory().getModules() != null) {
                    String modulesStr = pc.getMemory().getModules().toLowerCase().trim();
                    try {
                        String[] parts = modulesStr.split("x");
                        if (parts.length >= 2) {
                            int moduleCount = Integer.parseInt(parts[0].trim());
                            int moduleSize = Integer.parseInt(parts[1].trim());
                            int totalRam = moduleCount * moduleSize;
                            score += Math.min(totalRam / 4, 7);
                        }
                    } catch (NumberFormatException e) {
                        // Handle exception
                    }
                }
                
                // CAS latency (up to 5 points)
                if (pc.getMemory().getCasLatency() != null) {
                    double casLatency = pc.getMemory().getCasLatency().doubleValue();
                    if (casLatency < 14) score += 5;
                    else if (casLatency < 16) score += 4;
                    else if (casLatency < 18) score += 3;
                    else if (casLatency < 20) score += 2;
                    else score += 1;
                }
                
                // First word latency (up to 2 points)
                if (pc.getMemory().getFirstWordLatency() != null) {
                    double fwl = pc.getMemory().getFirstWordLatency().doubleValue();
                    if (fwl < 10) score += 2;
                    else if (fwl < 12) score += 1;
                }
            }

            // 4. Storage Performance (up to 10 points)
            if (pc.getInternalHardDrive() != null) {
                // SSD detection
                if (pc.getInternalHardDrive().getType() != null && 
                    "SSD".equalsIgnoreCase(pc.getInternalHardDrive().getType())) {
                    score += 5;
                    
                    // Interface speed
                    if (pc.getInternalHardDrive().getInterfaceType() != null) {
                        String interface_type = pc.getInternalHardDrive().getInterfaceType().toLowerCase();
                        if (interface_type.contains("nvme") || interface_type.contains("pcie")) {
                            score += 3;
                        } else if (interface_type.contains("sata") && interface_type.contains("3")) {
                            score += 2;
                        } else {
                            score += 1;
                        }
                    }
                    
                    // Capacity bonus
                    if (pc.getInternalHardDrive().getCapacity() != null) {
                        double capacity = pc.getInternalHardDrive().getCapacity().doubleValue();
                        score += Math.min((int)(capacity / 500), 2); // 500GB = 1pt, 1TB = 2pts
                    }
                } else {
                    // HDD gets some points
                    score += 2;
                }
            }

            // External drive bonus
            if (pc.getExternalHardDrive() != null && 
                pc.getExternalHardDrive().getType() != null && 
                "SSD".equalsIgnoreCase(pc.getExternalHardDrive().getType())) {
                score += 2;
            }

            // 5. System Cooling (up to 5 points)
            if (pc.getCpuCooler() != null) {
                // CPU cooler quality by size
                if (pc.getCpuCooler().getSize() != null) {
                    String coolerSize = pc.getCpuCooler().getSize().toLowerCase();
                    if (coolerSize.contains("240") || coolerSize.contains("280") || 
                        coolerSize.contains("360") || coolerSize.contains("water")) {
                        score += 3; // AIO liquid cooler
                    } else if (coolerSize.contains("tower") || 
                               Integer.parseInt(coolerSize.replaceAll("[^0-9]", "")) > 120) {
                        score += 2; // Tower air cooler
                    } else {
                        score += 1; // Stock or small cooler
                    }
                }
                
                // Low noise bonus
                if (pc.getCpuCooler().getNoiseLevel() != null) {
                    String noise = pc.getCpuCooler().getNoiseLevel().toLowerCase();
                    try {
                        // Extract the numeric value
                        String numericPart = noise.replaceAll("[^0-9.]", "");
                        if (!numericPart.isEmpty()) {
                            double noiseLevel = Double.parseDouble(numericPart);
                            if (noiseLevel < 25) score += 2;
                            else if (noiseLevel < 30) score += 1;
                        } else {
                            // If we can't parse, check for quiet/silent keywords
                            if (noise.contains("silent") || noise.contains("quiet")) {
                                score += 1;
                            }
                        }
                    } catch (NumberFormatException e) {
                        // If we can't parse, check for quiet/silent keywords
                        if (noise.contains("silent") || noise.contains("quiet")) {
                            score += 1;
                        }
                    }
                }
            }
            
            // Case fans
            if (pc.getCaseFan() != null) {
                // Check airflow if available
                if (pc.getCaseFan().getAirflow() != null) {
                    String airflow = pc.getCaseFan().getAirflow();
                    try {
                        String numericPart = airflow.replaceAll("[^0-9.]", "");
                        if (!numericPart.isEmpty()) {
                            double airflowValue = Double.parseDouble(numericPart);
                            if (airflowValue > 70) score += 2;
                            else if (airflowValue > 50) score += 1;
                        }
                    } catch (NumberFormatException e) {
                        // No action needed if parsing fails
                    }
                }
                
                // PWM fan bonus
                if (pc.getCaseFan().getPwm() != null && pc.getCaseFan().getPwm()) {
                    score += 1;
                }
            }

            // 6. Power Supply Quality (up to 10 points)
            if (pc.getPowerSupply() != null) {
                // Efficiency rating
                if (pc.getPowerSupply().getEfficiency() != null) {
                    String eff = pc.getPowerSupply().getEfficiency().toLowerCase();
                    if (eff.contains("titanium")) score += 6;
                    else if (eff.contains("platinum")) score += 5;
                    else if (eff.contains("gold")) score += 4;
                    else if (eff.contains("silver")) score += 3;
                    else if (eff.contains("bronze")) score += 2;
                    else score += 1;
                }
                
                // Modularity bonus
                if (pc.getPowerSupply().getModular() != null) {
                    String modular = pc.getPowerSupply().getModular().toLowerCase();
                    if (modular.contains("full")) score += 4;
                    else if (modular.contains("semi")) score += 2;
                    else score += 0;
                }
            }

            // 7. Fan controller bonus (if present)
            if (pc.getFanController() != null) {
                // Basic points for having a fan controller
                score += 2;
                
                // Extra points for PWM support
                if (pc.getFanController().getPwm() != null && pc.getFanController().getPwm()) {
                    score += 1;
                }
                
                // Extra points for higher channel count
                if (pc.getFanController().getChannels() != null && pc.getFanController().getChannels() >= 6) {
                    score += 1;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Return normalized score, max 100
        return Math.min(score, 100);
    }

    public int[] getTotalScore(Pc pc) {
        int[] res = new int[2];
        res[0] = calculateCompatibilityScore(pc);
        res[1] = calculatePerformanceScore(pc);
        return res;
    }

    private int estimateTotalPower(Pc pc) {
        int power = 0;
        
        // CPU power
        if (pc.getCpu() != null && pc.getCpu().getTdp() != null) {
            power += pc.getCpu().getTdp();
        } else {
            power += 95; // Default CPU power estimate
        }
        
        // GPU power
        if (pc.getVideoCard() != null) {
            // Estimate based on memory size if available
            if (pc.getVideoCard().getMemory() != null) {
                int gpuMemory = pc.getVideoCard().getMemory().intValue();
                power += gpuMemory * 25; // Rough estimate: 4GB = 100W, 8GB = 200W, etc.
            } else {
                power += 150; // Default GPU power estimate
            }
        }
        
        // Motherboard + RAM + Storage + Fans base power
        power += 75;
        return power;
    }
        public int estimateTotalPower(cpu cpu, video_card videoCard) {
        int power = 0;

        // Estimate CPU TDP
        if (cpu != null && cpu.getTdp() != null) {
            power += cpu.getTdp();
        } else {
            power += 95; // Default CPU power estimate
        }

        // Estimate GPU power based on memory size
        if (videoCard != null) {
            if (videoCard.getMemory() != null) {
                int gpuMemory = videoCard.getMemory().intValue();
                power += gpuMemory * 25; // e.g., 4GB = 100W
            } else {
                power += 150; // Default GPU power estimate
            }
        }

        // Base power for motherboard, RAM, storage, and fans
        power += 75;

        return power;
    }

}