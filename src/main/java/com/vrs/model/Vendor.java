package com.vrs.model;

public class Vendor {

    private int vendorId;
    private int userId;
    private String agencyName;
    private String shopAddress;
    private String description;
    private String approvalStatus;

    public Vendor() {
    }

    public Vendor(int vendorId, int userId, String agencyName,
                  String shopAddress, String description,
                  String approvalStatus) {
        this.vendorId = vendorId;
        this.userId = userId;
        this.agencyName = agencyName;
        this.shopAddress = shopAddress;
        this.description = description;
        this.approvalStatus = approvalStatus;
    }

    public Vendor(int userId, String agencyName,
                  String shopAddress, String description,
                  String approvalStatus) {
        this.userId = userId;
        this.agencyName = agencyName;
        this.shopAddress = shopAddress;
        this.description = description;
        this.approvalStatus = approvalStatus;
    }

    public int getVendorId() {
        return vendorId;
    }

    public void setVendorId(int vendorId) {
        this.vendorId = vendorId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getShopAddress() {
        return shopAddress;
    }

    public void setShopAddress(String shopAddress) {
        this.shopAddress = shopAddress;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    @Override
    public String toString() {
        return "Vendor [vendorId=" + vendorId +
                ", userId=" + userId +
                ", agencyName=" + agencyName +
                ", shopAddress=" + shopAddress +
                ", description=" + description +
                ", approvalStatus=" + approvalStatus + "]";
    }
}