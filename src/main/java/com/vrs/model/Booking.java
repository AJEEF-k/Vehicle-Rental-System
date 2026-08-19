package com.vrs.model;

import java.time.LocalDateTime;

public class Booking {

    private int bookingId;
    private int userId;
    private int vehicleId;
    private LocalDateTime bookingDate;
    private LocalDateTime startDateTime;
    private LocalDateTime endDateTime;
    private String bookingStatus;
    private String paymentMethod;
    private String paymentStatus;
    private String rateType;
    private int appliedRate;
    private int totalAmount;
    private int securityDeposit;

    public Booking() {
    }

    public Booking(int bookingId, int userId, int vehicleId,
                   LocalDateTime bookingDate,
                   LocalDateTime startDateTime,
                   LocalDateTime endDateTime,
                   String bookingStatus,
                   String paymentMethod,
                   String paymentStatus,
                   String rateType,
                   int appliedRate,
                   int totalAmount,
                   int securityDeposit) {

        this.bookingId = bookingId;
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.bookingDate = bookingDate;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.bookingStatus = bookingStatus;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.rateType = rateType;
        this.appliedRate = appliedRate;
        this.totalAmount = totalAmount;
        this.securityDeposit = securityDeposit;
    }

    public Booking(int userId, int vehicleId,
                   LocalDateTime bookingDate,
                   LocalDateTime startDateTime,
                   LocalDateTime endDateTime,
                   String bookingStatus,
                   String paymentMethod,
                   String paymentStatus,
                   String rateType,
                   int appliedRate,
                   int totalAmount,
                   int securityDeposit) {

        this.userId = userId;
        this.vehicleId = vehicleId;
        this.bookingDate = bookingDate;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.bookingStatus = bookingStatus;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.rateType = rateType;
        this.appliedRate = appliedRate;
        this.totalAmount = totalAmount;
        this.securityDeposit = securityDeposit;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public LocalDateTime getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }

    public LocalDateTime getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(LocalDateTime startDateTime) {
        this.startDateTime = startDateTime;
    }

    public LocalDateTime getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(LocalDateTime endDateTime) {
        this.endDateTime = endDateTime;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getRateType() {
        return rateType;
    }

    public void setRateType(String rateType) {
        this.rateType = rateType;
    }

    public int getAppliedRate() {
        return appliedRate;
    }

    public void setAppliedRate(int appliedRate) {
        this.appliedRate = appliedRate;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getSecurityDeposit() {
        return securityDeposit;
    }

    public void setSecurityDeposit(int securityDeposit) {
        this.securityDeposit = securityDeposit;
    }

    @Override
    public String toString() {
        return "Booking [bookingId=" + bookingId +
                ", userId=" + userId +
                ", vehicleId=" + vehicleId +
                ", bookingDate=" + bookingDate +
                ", startDateTime=" + startDateTime +
                ", endDateTime=" + endDateTime +
                ", bookingStatus=" + bookingStatus +
                ", paymentMethod=" + paymentMethod +
                ", paymentStatus=" + paymentStatus +
                ", rateType=" + rateType +
                ", appliedRate=" + appliedRate +
                ", totalAmount=" + totalAmount +
                ", securityDeposit=" + securityDeposit + "]";
    }
}