class RegExpClass {
  final RegExp nameRegExp =
      RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null; // Input is valid
  }
  
}
