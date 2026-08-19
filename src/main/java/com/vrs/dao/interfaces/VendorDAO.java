package com.vrs.dao.interfaces;

import java.util.List;

import com.vrs.model.Vendor;

public interface VendorDAO {

    boolean addVendor(Vendor vendor);

    Vendor getVendorById(int vendorId);

    Vendor getVendorByUserId(int userId);

    List<Vendor> getAllVendors();

    boolean updateApprovalStatus(int vendorId, String approvalStatus);

    boolean updateVendor(Vendor vendor);
}  