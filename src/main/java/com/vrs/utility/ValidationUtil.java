package com.vrs.utility;

public class ValidationUtil {

    private ValidationUtil() {
    }

    public static boolean isValidEmail(String email) {

        if (email == null || email.isBlank()) {
            return false;
        }

        return email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        );
    }

    public static boolean isValidPhone(String phone) {

        if (phone == null || phone.isBlank()) {
            return false;
        }

        return phone.matches("\\d{10}");
    }

    public static boolean isValidPassword(String password) {

        if (password == null || password.length() < 8) {
            return false;
        }

        return true;
    }
}