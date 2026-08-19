/**
 * Booking form validation
 */

function validateBookingForm() {

    const startInput =
        document.getElementById("startDateTime");

    const endInput =
        document.getElementById("endDateTime");

    const rateType =
        document.getElementById("rateType");

    const paymentMethod =
        document.getElementById("paymentMethod");

    if (!startInput || !endInput ||
        !rateType || !paymentMethod) {

        return true;
    }

    const start = new Date(startInput.value);
    const end = new Date(endInput.value);
    const now = new Date();

    if (isNaN(start.getTime()) ||
        isNaN(end.getTime())) {

        alert("Please enter valid start and end date/time.");

        return false;
    }

    if (start < now) {

        alert("Start date and time cannot be in the past.");

        startInput.focus();

        return false;
    }

    if (end <= start) {

        alert("End date and time must be after the start date and time.");

        endInput.focus();

        return false;
    }

    if (!rateType.value) {

        alert("Please select a rate type.");

        rateType.focus();

        return false;
    }

    if (!paymentMethod.value) {

        alert("Please select a payment method.");

        paymentMethod.focus();

        return false;
    }

    return true;
}