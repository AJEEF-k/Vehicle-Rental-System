package com.vrs.model;

public class Review {

    private int reviewId;
    private int bookingId;
    private int vehicleRating;
    private int vendorRating;

    public Review() {  
    	
    }

    public Review(int reviewId, int bookingId,
                  int vehicleRating, int vendorRating) {
        this.reviewId = reviewId;
        this.bookingId = bookingId;
        this.vehicleRating = vehicleRating;
        this.vendorRating = vendorRating;
    }      

    public Review(int bookingId,  
                  int vehicleRating, int vendorRating) {
        this.bookingId = bookingId;
        this.vehicleRating = vehicleRating;
        this.vendorRating = vendorRating;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getVehicleRating() {
        return vehicleRating;
    }

    public void setVehicleRating(int vehicleRating) {
        this.vehicleRating = vehicleRating;
    }

    public int getVendorRating() {
        return vendorRating;
    }

    public void setVendorRating(int vendorRating) {
        this.vendorRating = vendorRating;
    }

    @Override
    public String toString() {
        return "Review [reviewId=" + reviewId +
                ", bookingId=" + bookingId +
                ", vehicleRating=" + vehicleRating +
                ", vendorRating=" + vendorRating + "]";
    }
}