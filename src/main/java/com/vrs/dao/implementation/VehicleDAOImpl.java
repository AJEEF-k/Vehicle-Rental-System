package com.vrs.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.vrs.config.DBConnection;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.model.Vehicle;

public class VehicleDAOImpl implements VehicleDAO {

    @Override
    public boolean addVehicle(Vehicle vehicle) {

        String sql = "INSERT INTO vehicles "
                   + "(vendor_id, registration_number, vehicle_name, brand, "
                   + "category, hourly_rate, daily_rate, battery_range, "
                   + "image_path, operational_status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vehicle.getVendorId());
            statement.setString(2, vehicle.getRegistrationNumber());
            statement.setString(3, vehicle.getVehicleName());
            statement.setString(4, vehicle.getBrand());
            statement.setString(5, vehicle.getCategory());
            statement.setInt(6, vehicle.getHourlyRate());
            statement.setInt(7, vehicle.getDailyRate());
            statement.setInt(8, vehicle.getBatteryRange());
            statement.setString(9, vehicle.getImagePath());
            statement.setString(10, vehicle.getOperationalStatus());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Vehicle getVehicleById(int vehicleId) {

        String sql = "SELECT vehicle_id, vendor_id, registration_number, "
                   + "vehicle_name, brand, category, hourly_rate, daily_rate, "
                   + "battery_range, image_path, operational_status "
                   + "FROM vehicles WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vehicleId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResultSetToVehicle(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Vehicle> getAllVehicles() {

        List<Vehicle> vehicles = new ArrayList<>();

        String sql = "SELECT vehicle_id, vendor_id, registration_number, "
                   + "vehicle_name, brand, category, hourly_rate, daily_rate, "
                   + "battery_range, image_path, operational_status "
                   + "FROM vehicles "
                   + "WHERE operational_status = 'Available' "
                   + "ORDER BY vehicle_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                vehicles.add(mapResultSetToVehicle(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }
    
    
  
    @Override
    public List<Vehicle> getAllVehiclesForAdmin() {

        List<Vehicle> vehicles = new ArrayList<>();

        String sql = "SELECT vehicle_id, vendor_id, registration_number, "
                   + "vehicle_name, brand, category, hourly_rate, daily_rate, "
                   + "battery_range, image_path, operational_status "
                   + "FROM vehicles "
                   + "ORDER BY vehicle_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                vehicles.add(mapResultSetToVehicle(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }
    
    
    

    @Override
    public List<Vehicle> getVehiclesByVendorId(int vendorId) {

        List<Vehicle> vehicles = new ArrayList<>();

        String sql = "SELECT vehicle_id, vendor_id, registration_number, "
                   + "vehicle_name, brand, category, hourly_rate, daily_rate, "
                   + "battery_range, image_path, operational_status "
                   + "FROM vehicles "
                   + "WHERE vendor_id = ? "
                   + "ORDER BY vehicle_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vendorId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    vehicles.add(mapResultSetToVehicle(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }

    @Override
    public List<Vehicle> searchVehicles(String keyword) {

        List<Vehicle> vehicles = new ArrayList<>();

        String sql = "SELECT vehicle_id, vendor_id, registration_number, "
                   + "vehicle_name, brand, category, hourly_rate, daily_rate, "
                   + "battery_range, image_path, operational_status "
                   + "FROM vehicles "
                   + "WHERE operational_status = 'Available' "
                   + "AND (vehicle_name LIKE ? "
                   + "OR brand LIKE ? "
                   + "OR category LIKE ?) "
                   + "ORDER BY vehicle_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    vehicles.add(mapResultSetToVehicle(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }

    @Override
    public boolean updateVehicle(Vehicle vehicle) {

        String sql = "UPDATE vehicles "
                   + "SET vehicle_name = ?, brand = ?, category = ?, "
                   + "hourly_rate = ?, daily_rate = ?, battery_range = ?, "
                   + "image_path = ? "
                   + "WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, vehicle.getVehicleName());
            statement.setString(2, vehicle.getBrand());
            statement.setString(3, vehicle.getCategory());
            statement.setInt(4, vehicle.getHourlyRate());
            statement.setInt(5, vehicle.getDailyRate());
            statement.setInt(6, vehicle.getBatteryRange());
            statement.setString(7, vehicle.getImagePath());
            statement.setInt(8, vehicle.getVehicleId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateOperationalStatus(int vehicleId, String status) {

        String sql = "UPDATE vehicles "
                   + "SET operational_status = ? "
                   + "WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, vehicleId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean isVehicleAvailable(int vehicleId,
                                      LocalDateTime startDateTime,
                                      LocalDateTime endDateTime) {

        String sql = "SELECT 1 "
                   + "FROM vehicles v "
                   + "WHERE v.vehicle_id = ? "
                   + "AND v.operational_status = 'Available' "
                   + "AND NOT EXISTS ( "
                   + "    SELECT 1 "
                   + "    FROM bookings b "
                   + "    WHERE b.vehicle_id = v.vehicle_id "
                   + "    AND b.booking_status <> 'Cancelled' "
                   + "    AND b.start_datetime < ? "
                   + "    AND b.end_datetime > ? "
                   + ")";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vehicleId);
            statement.setTimestamp(2, Timestamp.valueOf(endDateTime));
            statement.setTimestamp(3, Timestamp.valueOf(startDateTime));

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private Vehicle mapResultSetToVehicle(ResultSet resultSet)
            throws SQLException {

        Vehicle vehicle = new Vehicle();

        vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
        vehicle.setVendorId(resultSet.getInt("vendor_id"));
        vehicle.setRegistrationNumber(
                resultSet.getString("registration_number"));
        vehicle.setVehicleName(resultSet.getString("vehicle_name"));
        vehicle.setBrand(resultSet.getString("brand"));
        vehicle.setCategory(resultSet.getString("category"));
        vehicle.setHourlyRate(resultSet.getInt("hourly_rate"));
        vehicle.setDailyRate(resultSet.getInt("daily_rate"));
        vehicle.setBatteryRange(resultSet.getInt("battery_range"));
        vehicle.setImagePath(resultSet.getString("image_path"));
        vehicle.setOperationalStatus(
                resultSet.getString("operational_status"));

        return vehicle;
    }
}