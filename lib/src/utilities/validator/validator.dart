class Validator {
  static String? empty({String? input, String? errorMessage}) {
    if (input!.isEmpty) {
      return errorMessage ?? "This Field can not be empty";
    }
    return null;
  }

  static String? characterLength(
      {String? input, String? errorMessage, int minimumLength = 7}) {
    if ((input?.trim().length ?? 0) <= minimumLength) {
      return errorMessage ?? "Password must be at least 8 characters";
    }
    return null;
  }

  static String? confirmPassword(
      {String? input, String? password, String? errorMessage}) {
    if ((input?.trim() ?? "") != (password?.trim() ?? "")) {
      return errorMessage ?? "Password mismatch";
    }
    return null;
  }
}
