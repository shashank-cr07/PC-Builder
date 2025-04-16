package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "case_fan")
public class case_fan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @Column(name = "size")
    private Integer size;

    @Column(name = "color", length = 50)
    private String color;

    @Column(name = "rpm", length = 50)
    private String rpm;

    @Column(name = "airflow", length = 50)
    private String airflow;

    @Column(name = "noise_level", length = 50)
    private String noiseLevel;

    @Column(name = "pwm")
    private Boolean pwm;

    public case_fan() {}

    public case_fan(String name, BigDecimal price, Integer size, String color, String rpm, String airflow, String noiseLevel, Boolean pwm) {
        this.name = name;
        this.price = price;
        this.size = size;
        this.color = color;
        this.rpm = rpm;
        this.airflow = airflow;
        this.noiseLevel = noiseLevel;
        this.pwm = pwm;
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

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getRpm() {
        return rpm;
    }

    public void setRpm(String rpm) {
        this.rpm = rpm;
    }

    public String getAirflow() {
        return airflow;
    }

    public void setAirflow(String airflow) {
        this.airflow = airflow;
    }

    public String getNoiseLevel() {
        return noiseLevel;
    }

    public void setNoiseLevel(String noiseLevel) {
        this.noiseLevel = noiseLevel;
    }

    public Boolean getPwm() {
        return pwm;
    }

    public void setPwm(Boolean pwm) {
        this.pwm = pwm;
    }
}
