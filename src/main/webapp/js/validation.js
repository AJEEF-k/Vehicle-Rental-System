/**
 * Common form validation
 */

function validatePasswordMatch(passwordId, confirmPasswordId) {

    const password = document.getElementById(passwordId);
    const confirmPassword = document.getElementById(confirmPasswordId);

    if (!password || !confirmPassword) {
        return true;
    }

    if (password.value !== confirmPassword.value) {

        alert("Passwords do not match.");

        confirmPassword.focus();

        return false;
    }

    return true;
}


function validatePasswordForm(formId) {

    const form = document.getElementById(formId);

    if (!form) {
        return true;
    }

    return validatePasswordMatch(
        "newPassword",
        "confirmPassword"
    );
}