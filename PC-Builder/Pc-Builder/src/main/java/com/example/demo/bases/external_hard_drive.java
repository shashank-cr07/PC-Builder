package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "external_hard_drive")
public class external_hard_drive {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 50)
    private String type;

    @Column(name = "interface", columnDefinition = "TEXT")
    private String interfaceType;


    private Integer capacity;

    @Column(name = "price_per_gb", precision = 10, scale = 2)
    private BigDecimal pricePerGb;

    @Column(length = 50)
    private String color;

    public external_hard_drive() {}

    public external_hard_drive(String name, BigDecimal price, String type, String interfaceType, Integer capacity, BigDecimal pricePerGb, String color) {
        this.name = name;
        this.price = price;
        this.type = type;
        this.interfaceType = interfaceType;
        this.capacity = capacity;
        this.pricePerGb = pricePerGb;
        this.color = color;
    }

    // Getters and setters

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getInterfaceType() { return interfaceType; }
    public void setInterfaceType(String interfaceType) { this.interfaceType = interfaceType; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public BigDecimal getPricePerGb() { return pricePerGb; }
    public void setPricePerGb(BigDecimal pricePerGb) { this.pricePerGb = pricePerGb; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}
