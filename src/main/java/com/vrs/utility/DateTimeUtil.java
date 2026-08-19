package com.vrs.utility;

import java.time.LocalDateTime;

public class DateTimeUtil {

    private DateTimeUtil() {
    }

    public static boolean isValidRentalPeriod(
            LocalDateTime startDateTime,
            LocalDateTime endDateTime) {

        if (startDateTime == null || endDateTime == null) {
            return false;
        }

        return endDateTime.isAfter(startDateTime);
    }
}