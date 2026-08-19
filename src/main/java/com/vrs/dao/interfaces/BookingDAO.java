package com.vrs.dao.interfaces;

import java.time.LocalDateTime;
import java.util.List;

import com.vrs.model.Booking;

public interface BookingDAO {

    boolean createBooking(Booking booking);
  
    Booking getBookingById(int bookingId);

    List<Booking> getBookingsByUserId(int userId);

    List<Booking> getBookingsByVehicleId(int vehicleId);

    List<Booking> getBookingsByVendorId(int vendorId);

    boolean updateBookingStatus(int bookingId, String bookingStatus);

    boolean cancelBooking(int bookingId);   

    boolean isVehicleAvailable(int vehicleId,
                               LocalDateTime startDateTime,
                               LocalDateTime endDateTime);

    List<Booking> getAllBookings();
}