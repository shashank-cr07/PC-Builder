package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "internal_hard_drive")
public class internal_hard_drive {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(precision = 10, scale = 2)
    private BigDecimal capacity;

    @Column(name = "price_per_gb", precision = 10, scale = 4)
    private BigDecimal pricePerGb;

    @Column(length = 20)
    private String type;

    private Integer cache;

    @Column(name = "form_factor", length = 50)
    private String formFactor;

    @Column(name = "interface", columnDefinition = "TEXT" ,length =100)
    private String interfaceType;

    public internal_hard_drive() {}

    public internal_hard_drive(String name, BigDecimal price, BigDecimal capacity, BigDecimal pricePerGb,
                               String type, Integer cache, String formFactor, String interfaceType) {
        this.name = name;
        this.price = price;
        this.capacity = capacity;
        this.pricePerGb = pricePerGb;
        this.type = type;
        this.cache = cache;
        this.formFactor = formFactor;
        this.interfaceType = interfaceType;
    }

    // Getters and setters...

    public Integer getId() { return id; }

    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }

    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getCapacity() { return capacity; }

    public void setCapacity(BigDecimal capacity) { this.capacity = capacity; }

    public BigDecimal getPricePerGb() { return pricePerGb; }

    public void setPricePerGb(BigDecimal pricePerGb) { this.pricePerGb = pricePerGb; }

    public String getType() { return type; }

    public void setType(String type) { this.type = type; }

    public Integer getCache() { return cache; }

    public void setCache(Integer cache) { this.cache = cache; }

    public String getFormFactor() { return formFactor; }

    public void setFormFactor(String formFactor) { this.formFactor = formFactor; }

    public String getInterfaceType() { return interfaceType; }

    public void setInterfaceType(String interfaceType) { this.interfaceType = interfaceType; }
}
