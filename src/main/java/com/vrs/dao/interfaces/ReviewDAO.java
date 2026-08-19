package com.vrs.dao.interfaces;

import java.util.List;

import com.vrs.model.Review;

public interface ReviewDAO {

    boolean addReview(Review review);

    Review getReviewByBookingId(int bookingId);

    List<Review> getAllReviews();

    boolean hasReview(int bookingId);
}