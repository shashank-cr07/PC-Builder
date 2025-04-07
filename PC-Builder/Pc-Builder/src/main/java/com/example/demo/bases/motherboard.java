package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "motherboard")
public class motherboard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 50)
    private String socket;

    @Column(name = "form_factor", length = 50)
    private String formFactor;

    private Integer maxMemory;
    private Integer memorySlots;

    @Column(length = 50)
    private String color;

    public motherboard() {}

    public motherboard(String name, BigDecimal price, String socket, String formFactor,
                       Integer maxMemory, Integer memorySlots, String color) {
        this.name = name;
        this.price = price;
        this.socket = socket;
        this.formFactor = formFactor;
        this.maxMemory = maxMemory;
        this.memorySlots = memorySlots;
        this.color = color;
    }

    // Getters and Setters

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getSocket() { return socket; }
    public void setSocket(String socket) { this.socket = socket; }

    public String getFormFactor() { return formFactor; }
    public void setFormFactor(String formFactor) { this.formFactor = formFactor; }

    public Integer getMaxMemory() { return maxMemory; }
    public void setMaxMemory(Integer maxMemory) { this.maxMemory = maxMemory; }

    public Integer getMemorySlots() { return memorySlots; }
    public void setMemorySlots(Integer memorySlots) { this.memorySlots = memorySlots; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}
