package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "thermal_paste")
public class thermal_paste {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @Column(precision = 5, scale = 2)
    private BigDecimal amount;

    public thermal_paste() {}

    public thermal_paste(String name, BigDecimal price, BigDecimal amount) {
        this.name = name;
        this.price = price;
        this.amount = amount;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
}
