package com.example.demo.bases;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "fan_controller")
public class fan_controller {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    private Integer channels;

    @Column(name = "channel_wattage", precision = 10, scale = 2)
    private BigDecimal channelWattage;

    private Boolean pwm;

    @Column(name = "form_factor", length = 50)
    private String formFactor;

    @Column(length = 50)
    private String color;

    public fan_controller() {}

    public fan_controller(String name, BigDecimal price, Integer channels, BigDecimal channelWattage, Boolean pwm, String formFactor, String color) {
        this.name = name;
        this.price = price;
        this.channels = channels;
        this.channelWattage = channelWattage;
        this.pwm = pwm;
        this.formFactor = formFactor;
        this.color = color;
    }

    // Getters and setters...

    public Integer getId() { return id; }

    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }

    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getChannels() { return channels; }

    public void setChannels(Integer channels) { this.channels = channels; }

    public BigDecimal getChannelWattage() { return channelWattage; }

    public void setChannelWattage(BigDecimal channelWattage) { this.channelWattage = channelWattage; }

    public Boolean getPwm() { return pwm; }

    public void setPwm(Boolean pwm) { this.pwm = pwm; }

    public String getFormFactor() { return formFactor; }

    public void setFormFactor(String formFactor) { this.formFactor = formFactor; }

    public String getColor() { return color; }

    public void setColor(String color) { this.color = color; }
}
