String? validateEmail(String email) {
  // Regular expression for email validation
  const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final RegExp regex = RegExp(emailPattern);

  if (email.isEmpty || email.trim().isEmpty) { 
    return 'Email is required';
  } else if (!regex.hasMatch(email)) {
    return 'Enter a valid email';
  }
  return null; // Valid email
}

//Validate phone number
String? validatePhone(String phone) {
  // Regular expression for phone number validation
  // phone number can be any length with minimum how much digit?
  const String phonePattern = r'^[0-9]{6,}$';
  final RegExp regex = RegExp(phonePattern);

  if (phone.isEmpty || phone.trim().isEmpty) {
    return 'Phone number is required';
  } else if (!regex.hasMatch(phone)) {
    return 'Enter a valid phone number';
  }
  return null; // Valid phone number
}

String? validatePassword(String password) {
  if (password.isEmpty || password.trim().isEmpty) {
    return 'Password is required';
  } else if (password.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  } else if (!password.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  } else if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  } else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }
  return null; // Valid password
}

String? validateFirstName(String firstName) {
  if (firstName.isEmpty || firstName.trim().isEmpty) {
    return 'First name is required';
  } else if (firstName.length < 2) {
    return 'First name must be at least 2 characters';
  }
  return null; // Valid first name
}

String? validateLastName(String lastName) {
  if (lastName.isEmpty || lastName.trim().isEmpty) {
    return 'Last name is required';
  } else if (lastName.length < 2) {
    return 'Last name must be at least 2 characters';
  }
  return null; // Valid last name
}

String? validateRequiredField(String value, String fieldName) {
  if (value.isEmpty) {
    return '$fieldName is required';
  }
  // check with trim value
  if (value.trim().isEmpty) {
    return '$fieldName is required';
  }
  return null; // Valid field
}
