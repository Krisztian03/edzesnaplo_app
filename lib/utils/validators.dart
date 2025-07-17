// English: Common form validators
// Magyar: Általános űrlap validátorok

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value) ? null : 'Enter a valid email address';
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
