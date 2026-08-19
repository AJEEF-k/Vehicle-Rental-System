package com.vrs.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vrs.config.DBConnection;
import com.vrs.dao.interfaces.ReviewDAO;
import com.vrs.model.Review;

public class ReviewDAOImpl implements ReviewDAO {  

    @Override
    public boolean addReview(Review review) {

        String sql = "INSERT INTO reviews "
                   + "(booking_id, vehicle_rating, vendor_rating) "
                   + "SELECT ?, ?, ? "
                   + "FROM bookings "
                   + "WHERE booking_id = ? "
                   + "AND booking_status = 'Completed' "
                   + "AND NOT EXISTS ( "
                   + "    SELECT 1 FROM reviews "
                   + "    WHERE booking_id = ? "
                   + ")";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, review.getBookingId());
            statement.setInt(2, review.getVehicleRating());
            statement.setInt(3, review.getVendorRating());
            statement.setInt(4, review.getBookingId());
            statement.setInt(5, review.getBookingId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Review getReviewByBookingId(int bookingId) {

        String sql = "SELECT review_id, booking_id, "
                   + "vehicle_rating, vendor_rating "
                   + "FROM reviews "
                   + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResultSetToReview(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Review> getAllReviews() {

        List<Review> reviews = new ArrayList<>();

        String sql = "SELECT review_id, booking_id, "
                   + "vehicle_rating, vendor_rating "
                   + "FROM reviews "
                   + "ORDER BY review_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                reviews.add(mapResultSetToReview(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

    @Override
    public boolean hasReview(int bookingId) {

        String sql = "SELECT 1 FROM reviews WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private Review mapResultSetToReview(ResultSet resultSet)
            throws SQLException {

        Review review = new Review();

        review.setReviewId(resultSet.getInt("review_id"));
        review.setBookingId(resultSet.getInt("booking_id"));
        review.setVehicleRating(
                resultSet.getInt("vehicle_rating"));
        review.setVendorRating(
                resultSet.getInt("vendor_rating"));

        return review;
    }
}