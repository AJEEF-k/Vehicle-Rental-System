package com.vrs.dao.interfaces;

import java.time.LocalDateTime;
import java.util.List;

import com.vrs.model.Vehicle;

public interface VehicleDAO {

    boolean addVehicle(Vehicle vehicle);

    Vehicle getVehicleById(int vehicleId);

    List<Vehicle> getAllVehicles();
    
    List<Vehicle> getAllVehiclesForAdmin();

    List<Vehicle> getVehiclesByVendorId(int vendorId);

    List<Vehicle> searchVehicles(String keyword);

    boolean updateVehicle(Vehicle vehicle);

    boolean updateOperationalStatus(int vehicleId, String status);

    boolean isVehicleAvailable(int vehicleId,
                               LocalDateTime startDateTime,
                               LocalDateTime endDateTime);
}