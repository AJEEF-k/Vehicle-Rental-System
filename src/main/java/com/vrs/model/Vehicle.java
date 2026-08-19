package com.vrs.model;

public class Vehicle {

    private int vehicleId;
    private int vendorId;
    private String registrationNumber;
    private String vehicleName;
    private String brand;
    private String category;
    private int hourlyRate;
    private int dailyRate;
    private int batteryRange;
    private String imagePath;
    private String operationalStatus;

    public Vehicle() {
    }

    public Vehicle(int vehicleId, int vendorId, String registrationNumber,
                   String vehicleName, String brand, String category,
                   int hourlyRate, int dailyRate, int batteryRange,
                   String imagePath, String operationalStatus) {

        this.vehicleId = vehicleId;
        this.vendorId = vendorId;
        this.registrationNumber = registrationNumber;
        this.vehicleName = vehicleName;
        this.brand = brand;
        this.category = category;
        this.hourlyRate = hourlyRate;
        this.dailyRate = dailyRate;
        this.batteryRange = batteryRange;
        this.imagePath = imagePath;
        this.operationalStatus = operationalStatus;
    }

    public Vehicle(int vendorId, String registrationNumber,
                   String vehicleName, String brand, String category,
                   int hourlyRate, int dailyRate, int batteryRange,
                   String imagePath, String operationalStatus) {

        this.vendorId = vendorId;
        this.registrationNumber = registrationNumber;
        this.vehicleName = vehicleName;
        this.brand = brand;
        this.category = category;
        this.hourlyRate = hourlyRate;
        this.dailyRate = dailyRate;
        this.batteryRange = batteryRange;
        this.imagePath = imagePath;
        this.operationalStatus = operationalStatus;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getVendorId() {
        return vendorId;
    }

    public void setVendorId(int vendorId) {
        this.vendorId = vendorId;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(String vehicleName) {
        this.vehicleName = vehicleName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(int hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public int getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(int dailyRate) {
        this.dailyRate = dailyRate;
    }

    public int getBatteryRange() {
        return batteryRange;
    }

    public void setBatteryRange(int batteryRange) {
        this.batteryRange = batteryRange;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getOperationalStatus() {
        return operationalStatus;
    }

    public void setOperationalStatus(String operationalStatus) {
        this.operationalStatus = operationalStatus;
    }
   
    @Override
    public String toString() {
        return "Vehicle [vehicleId=" + vehicleId +
                ", vendorId=" + vendorId +
                ", registrationNumber=" + registrationNumber +
                ", vehicleName=" + vehicleName +
                ", brand=" + brand +
                ", category=" + category +
                ", hourlyRate=" + hourlyRate +
                ", dailyRate=" + dailyRate +
                ", batteryRange=" + batteryRange +
                ", imagePath=" + imagePath +
                ", operationalStatus=" + operationalStatus + "]";
    }
}