package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "os")
public class os {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 10)
    private String mode;

    private Integer maxMemory;

    public os() {}

    public os(String name, BigDecimal price, String mode, Integer maxMemory) {
        this.name = name;
        this.price = price;
        this.mode = mode;
        this.maxMemory = maxMemory;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getMode() { return mode; }
    public void setMode(String mode) { this.mode = mode; }

    public Integer getMaxMemory() { return maxMemory; }
    public void setMaxMemory(Integer maxMemory) { this.maxMemory = maxMemory; }
}
