package com.vrs.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vrs.config.DBConnection;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.Vendor;

public class VendorDAOImpl implements VendorDAO {

    @Override
    public boolean addVendor(Vendor vendor) {

        String sql = "INSERT INTO vendors "
                   + "(user_id, agency_name, shop_address, description, approval_status) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vendor.getUserId());
            statement.setString(2, vendor.getAgencyName());
            statement.setString(3, vendor.getShopAddress());
            statement.setString(4, vendor.getDescription());
            statement.setString(5, vendor.getApprovalStatus());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Vendor getVendorById(int vendorId) {

        String sql = "SELECT vendor_id, user_id, agency_name, "
                   + "shop_address, description, approval_status "
                   + "FROM vendors WHERE vendor_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vendorId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResultSetToVendor(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Vendor getVendorByUserId(int userId) {

        String sql = "SELECT vendor_id, user_id, agency_name, "
                   + "shop_address, description, approval_status "
                   + "FROM vendors WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResultSetToVendor(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Vendor> getAllVendors() {

        List<Vendor> vendors = new ArrayList<>();

        String sql = "SELECT vendor_id, user_id, agency_name, "
                   + "shop_address, description, approval_status "
                   + "FROM vendors ORDER BY vendor_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                vendors.add(mapResultSetToVendor(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vendors;
    }

    @Override
    public boolean updateApprovalStatus(int vendorId, String approvalStatus) {

        String sql = "UPDATE vendors "
                   + "SET approval_status = ? "
                   + "WHERE vendor_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, approvalStatus);
            statement.setInt(2, vendorId);
  
            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateVendor(Vendor vendor) {

        String sql = "UPDATE vendors "
                   + "SET agency_name = ?, shop_address = ?, description = ? "
                   + "WHERE vendor_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, vendor.getAgencyName());
            statement.setString(2, vendor.getShopAddress());
            statement.setString(3, vendor.getDescription());
            statement.setInt(4, vendor.getVendorId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private Vendor mapResultSetToVendor(ResultSet resultSet)
            throws SQLException {

        Vendor vendor = new Vendor();

        vendor.setVendorId(resultSet.getInt("vendor_id"));
        vendor.setUserId(resultSet.getInt("user_id"));
        vendor.setAgencyName(resultSet.getString("agency_name"));
        vendor.setShopAddress(resultSet.getString("shop_address"));
        vendor.setDescription(resultSet.getString("description"));
        vendor.setApprovalStatus(resultSet.getString("approval_status"));

        return vendor;
    }
}