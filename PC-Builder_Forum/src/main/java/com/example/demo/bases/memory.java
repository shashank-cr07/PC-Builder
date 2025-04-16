package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "memory")
public class memory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(length = 30)
    private String speed;

    @Column(length = 20)
    private String modules;

    @Column(name = "price_per_gb", precision = 10, scale = 3)
    private BigDecimal pricePerGb;

    @Column(length = 100)
    private String color;

    @Column(name = "first_word_latency", precision = 10, scale = 2)
    private BigDecimal firstWordLatency;

    @Column(name = "cas_latency", precision = 10, scale = 2)
    private BigDecimal casLatency;

    public memory() {}

    public memory(String name, BigDecimal price, String speed, String modules,
                  BigDecimal pricePerGb, String color, BigDecimal firstWordLatency, BigDecimal casLatency) {
        this.name = name;
        this.price = price;
        this.speed = speed;
        this.modules = modules;
        this.pricePerGb = pricePerGb;
        this.color = color;
        this.firstWordLatency = firstWordLatency;
        this.casLatency = casLatency;
    }

    // Getters and setters...

    public Integer getId() { return id; }

    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }

    public void setPrice(BigDecimal price) { this.price = price; }

    public String getSpeed() { return speed; }

    public void setSpeed(String speed) { this.speed = speed; }

    public String getModules() { return modules; }

    public void setModules(String modules) { this.modules = modules; }

    public BigDecimal getPricePerGb() { return pricePerGb; }

    public void setPricePerGb(BigDecimal pricePerGb) { this.pricePerGb = pricePerGb; }

    public String getColor() { return color; }

    public void setColor(String color) { this.color = color; }

    public BigDecimal getFirstWordLatency() { return firstWordLatency; }

    public void setFirstWordLatency(BigDecimal firstWordLatency) { this.firstWordLatency = firstWordLatency; }

    public BigDecimal getCasLatency() { return casLatency; }

    public void setCasLatency(BigDecimal casLatency) { this.casLatency = casLatency; }
}
