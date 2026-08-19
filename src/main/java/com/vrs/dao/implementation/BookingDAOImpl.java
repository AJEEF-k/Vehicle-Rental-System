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
import com.vrs.dao.interfaces.BookingDAO;
import com.vrs.model.Booking;

public class BookingDAOImpl implements BookingDAO {

    @Override
    public boolean createBooking(Booking booking) {

        String availabilitySql =
                "SELECT vehicle_id "
              + "FROM vehicles "
              + "WHERE vehicle_id = ? "
              + "AND operational_status = 'Available' "
              + "FOR UPDATE";

        String overlapSql =
                "SELECT 1 "
              + "FROM bookings "
              + "WHERE vehicle_id = ? "
              + "AND booking_status <> 'Cancelled' "
              + "AND start_datetime < ? "
              + "AND end_datetime > ? "
              + "LIMIT 1";

        String insertSql =
                "INSERT INTO bookings "
              + "(user_id, vehicle_id, booking_date, start_datetime, "
              + "end_datetime, booking_status, payment_method, "
              + "payment_status, rate_type, applied_rate, "
              + "total_amount, security_deposit) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {
                /*
                 * Lock the vehicle row so two customers cannot
                 * simultaneously pass the availability check.
                 */
                try (PreparedStatement availabilityStatement =
                        connection.prepareStatement(availabilitySql)) {

                    availabilityStatement.setInt(1, booking.getVehicleId());

                    try (ResultSet resultSet =
                            availabilityStatement.executeQuery()) {

                        if (!resultSet.next()) {
                            connection.rollback();
                            return false;
                        }
                    }
                }

                /*
                 * Check whether another booking overlaps
                 * with the requested rental period.
                 */
                try (PreparedStatement overlapStatement =
                        connection.prepareStatement(overlapSql)) {

                    overlapStatement.setInt(1, booking.getVehicleId());
                    overlapStatement.setTimestamp(
                            2,
                            Timestamp.valueOf(booking.getEndDateTime()));
                    overlapStatement.setTimestamp(
                            3,
                            Timestamp.valueOf(booking.getStartDateTime()));

                    try (ResultSet resultSet =
                            overlapStatement.executeQuery()) {

                        if (resultSet.next()) {
                            connection.rollback();
                            return false;
                        }
                    }
                }

                try (PreparedStatement insertStatement =
                        connection.prepareStatement(insertSql)) {

                    insertStatement.setInt(1, booking.getUserId());
                    insertStatement.setInt(2, booking.getVehicleId());
                    insertStatement.setTimestamp(
                            3,
                            Timestamp.valueOf(booking.getBookingDate()));
                    insertStatement.setTimestamp(
                            4,
                            Timestamp.valueOf(booking.getStartDateTime()));
                    insertStatement.setTimestamp(
                            5,
                            Timestamp.valueOf(booking.getEndDateTime()));
                    insertStatement.setString(
                            6,
                            booking.getBookingStatus());
                    insertStatement.setString(
                            7,
                            booking.getPaymentMethod());
                    insertStatement.setString(
                            8,
                            booking.getPaymentStatus());
                    insertStatement.setString(
                            9,
                            booking.getRateType());
                    insertStatement.setInt(
                            10,
                            booking.getAppliedRate());
                    insertStatement.setInt(
                            11,
                            booking.getTotalAmount());
                    insertStatement.setInt(
                            12,
                            booking.getSecurityDeposit());

                    boolean success =
                            insertStatement.executeUpdate() > 0;

                    if (success) {
                        connection.commit();
                    } else {
                        connection.rollback();
                    }

                    return success;
                }

            } catch (SQLException e) {

                connection.rollback();
                throw e;

            } finally {

                connection.setAutoCommit(true);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Booking getBookingById(int bookingId) {

        String sql = "SELECT booking_id, user_id, vehicle_id, booking_date, "
                   + "start_datetime, end_datetime, booking_status, "
                   + "payment_method, payment_status, rate_type, "
                   + "applied_rate, total_amount, security_deposit "
                   + "FROM bookings WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResultSetToBooking(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {

        String sql = "SELECT booking_id, user_id, vehicle_id, booking_date, "
                   + "start_datetime, end_datetime, booking_status, "
                   + "payment_method, payment_status, rate_type, "
                   + "applied_rate, total_amount, security_deposit "
                   + "FROM bookings "
                   + "WHERE user_id = ? "
                   + "ORDER BY booking_date DESC";

        return getBookings(sql, userId);
    }

    @Override
    public List<Booking> getBookingsByVehicleId(int vehicleId) {

        String sql = "SELECT booking_id, user_id, vehicle_id, booking_date, "
                   + "start_datetime, end_datetime, booking_status, "
                   + "payment_method, payment_status, rate_type, "
                   + "applied_rate, total_amount, security_deposit "
                   + "FROM bookings "
                   + "WHERE vehicle_id = ? "
                   + "ORDER BY booking_date DESC";

        return getBookings(sql, vehicleId);
    }

    @Override
    public List<Booking> getBookingsByVendorId(int vendorId) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, "
                   + "b.booking_date, b.start_datetime, b.end_datetime, "
                   + "b.booking_status, b.payment_method, "
                   + "b.payment_status, b.rate_type, b.applied_rate, "
                   + "b.total_amount, b.security_deposit "
                   + "FROM bookings b "
                   + "INNER JOIN vehicles v "
                   + "ON b.vehicle_id = v.vehicle_id "
                   + "WHERE v.vendor_id = ? "
                   + "ORDER BY b.booking_date DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, vendorId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookings.add(mapResultSetToBooking(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public boolean updateBookingStatus(int bookingId,
                                       String bookingStatus) {

        String sql = "UPDATE bookings "
                   + "SET booking_status = ? "
                   + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, bookingStatus);
            statement.setInt(2, bookingId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean cancelBooking(int bookingId) {

        String sql = "UPDATE bookings "
                   + "SET booking_status = 'Cancelled' "
                   + "WHERE booking_id = ? "
                   + "AND booking_status = 'Confirmed'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

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
            statement.setTimestamp(2,
                    Timestamp.valueOf(endDateTime));
            statement.setTimestamp(3,
                    Timestamp.valueOf(startDateTime));

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Booking> getAllBookings() {

        String sql = "SELECT booking_id, user_id, vehicle_id, booking_date, "
                   + "start_datetime, end_datetime, booking_status, "
                   + "payment_method, payment_status, rate_type, "
                   + "applied_rate, total_amount, security_deposit "
                   + "FROM bookings "
                   + "ORDER BY booking_date DESC";

        List<Booking> bookings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                bookings.add(mapResultSetToBooking(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    private List<Booking> getBookings(String sql, int id) {

        List<Booking> bookings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookings.add(mapResultSetToBooking(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    private Booking mapResultSetToBooking(ResultSet resultSet)
            throws SQLException {

        Booking booking = new Booking();

        booking.setBookingId(resultSet.getInt("booking_id"));
        booking.setUserId(resultSet.getInt("user_id"));
        booking.setVehicleId(resultSet.getInt("vehicle_id"));

        booking.setBookingDate(
                resultSet.getTimestamp("booking_date")
                        .toLocalDateTime());

        booking.setStartDateTime(
                resultSet.getTimestamp("start_datetime")
                        .toLocalDateTime());

        booking.setEndDateTime(
                resultSet.getTimestamp("end_datetime")
                        .toLocalDateTime());

        booking.setBookingStatus(
                resultSet.getString("booking_status"));

        booking.setPaymentMethod(
                resultSet.getString("payment_method"));

        booking.setPaymentStatus(
                resultSet.getString("payment_status"));

        booking.setRateType(
                resultSet.getString("rate_type"));

        booking.setAppliedRate(
                resultSet.getInt("applied_rate"));

        booking.setTotalAmount(
                resultSet.getInt("total_amount"));

        booking.setSecurityDeposit(
                resultSet.getInt("security_deposit"));

        return booking;
    }
}