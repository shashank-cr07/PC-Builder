package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "power_supply")
public class power_supply {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 50)
    private String type;

    @Column(length = 20)
    private String efficiency;

    private Integer wattage;

    @Column(length = 20)
    private String modular;

    @Column(length = 50)
    private String color;

    public power_supply() {}

    public power_supply(String name, BigDecimal price, String type, String efficiency, Integer wattage, String modular, String color) {
        this.name = name;
        this.price = price;
        this.type = type;
        this.efficiency = efficiency;
        this.wattage = wattage;
        this.modular = modular;
        this.color = color;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getEfficiency() { return efficiency; }
    public void setEfficiency(String efficiency) { this.efficiency = efficiency; }

    public Integer getWattage() { return wattage; }
    public void setWattage(Integer wattage) { this.wattage = wattage; }

    public String getModular() { return modular; }
    public void setModular(String modular) { this.modular = modular; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}
