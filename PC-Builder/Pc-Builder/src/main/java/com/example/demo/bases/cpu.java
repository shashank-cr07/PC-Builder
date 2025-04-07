package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "cpu")
public class cpu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @Column(name = "core_count")
    private Integer coreCount;

    @Column(name = "core_clock", precision = 10, scale = 2)
    private BigDecimal coreClock;

    @Column(name = "boost_clock", precision = 10, scale = 2)
    private BigDecimal boostClock;

    @Column(name = "tdp")
    private Integer tdp;

    @Column(name = "graphics", length = 100)
    private String graphics;

    @Column(name = "smt")
    private Boolean smt;

    public cpu() {}

    public cpu(String name, BigDecimal price, Integer coreCount, BigDecimal coreClock, BigDecimal boostClock,
               Integer tdp, String graphics, Boolean smt) {
        this.name = name;
        this.price = price;
        this.coreCount = coreCount;
        this.coreClock = coreClock;
        this.boostClock = boostClock;
        this.tdp = tdp;
        this.graphics = graphics;
        this.smt = smt;
    }

    // Getters and Setters

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getCoreCount() {
        return coreCount;
    }

    public void setCoreCount(Integer coreCount) {
        this.coreCount = coreCount;
    }

    public BigDecimal getCoreClock() {
        return coreClock;
    }

    public void setCoreClock(BigDecimal coreClock) {
        this.coreClock = coreClock;
    }

    public BigDecimal getBoostClock() {
        return boostClock;
    }

    public void setBoostClock(BigDecimal boostClock) {
        this.boostClock = boostClock;
    }

    public Integer getTdp() {
        return tdp;
    }

    public void setTdp(Integer tdp) {
        this.tdp = tdp;
    }

    public String getGraphics() {
        return graphics;
    }

    public void setGraphics(String graphics) {
        this.graphics = graphics;
    }

    public Boolean getSmt() {
        return smt;
    }

    public void setSmt(Boolean smt) {
        this.smt = smt;
    }
}
