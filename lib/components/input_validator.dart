class InputValidator {
  // Properties
  final _validName = RegExp(r'^[a-zA-Z0-9 ]+$');
  final _validEmailAddress = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _validPassword = RegExp(r'^.{6,}$');

  // Methods
  bool isValidName(String? name) {
    if (_validName.hasMatch(name!)) return true;
    return false;
  }

  bool isValidEmailAddress(String? emailAddress) {
    if (_validEmailAddress.hasMatch(emailAddress!)) return true;
    return false;
  }

  bool isValidPassword(String? password) {
    if (_validPassword.hasMatch(password!)) return true;
    return false;
  }

  bool isEmpty(String? input) {
    if (input!.isEmpty) return true;
    return false;
  }
}
