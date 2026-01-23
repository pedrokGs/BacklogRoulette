class Validators {
  static String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Email cannot be empty!";
    }
    final regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(regex).hasMatch(value)) {
      return "Email is invalid!";
    }
    return null;
  }

  static String? validatePassword(String? value){
    if (value!.trim().isEmpty) {
      return "Password cannot be empty!";
    }
    final regex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    if (!RegExp(regex).hasMatch(value)) {
      return "Password is not strong enough!";
    }
    return null;
  }

  static String? validateUsername(String? value){
    if (value!.trim().isEmpty) {
      return "Username cannot be empty!";
    }
    return null;
  }
}
