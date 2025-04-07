package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "case_table")
public class case_table {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @Column(name = "type", length = 50)
    private String type;

    @Column(name = "color", length = 50)
    private String color;

    @Column(name = "psu", length = 100)
    private String psu;

    @Column(name = "side_panel", length = 100)
    private String sidePanel;

    @Column(name = "external_volume", precision = 10, scale = 2)
    private BigDecimal externalVolume;

    @Column(name = "internal_35_bays")
    private Integer internal35Bays;

    public case_table() {}

    public case_table(String name, BigDecimal price, String type, String color, String psu, String sidePanel, BigDecimal externalVolume, Integer internal35Bays) {
        this.name = name;
        this.price = price;
        this.type = type;
        this.color = color;
        this.psu = psu;
        this.sidePanel = sidePanel;
        this.externalVolume = externalVolume;
        this.internal35Bays = internal35Bays;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getPsu() {
        return psu;
    }

    public void setPsu(String psu) {
        this.psu = psu;
    }

    public String getSidePanel() {
        return sidePanel;
    }

    public void setSidePanel(String sidePanel) {
        this.sidePanel = sidePanel;
    }

    public BigDecimal getExternalVolume() {
        return externalVolume;
    }

    public void setExternalVolume(BigDecimal externalVolume) {
        this.externalVolume = externalVolume;
    }

    public Integer getInternal35Bays() {
        return internal35Bays;
    }

    public void setInternal35Bays(Integer internal35Bays) {
        this.internal35Bays = internal35Bays;
    }
}
