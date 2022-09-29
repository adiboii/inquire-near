class InputValidator {
  // Properties
  final _validName = RegExp(r'^[a-zA-Z0-9 ]+$');
  final _validEmailAddress = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _validPassword = RegExp(r'^.{6,}$');

  // Methods
  bool isValidName(String? name) => _validName.hasMatch(name!);

  bool isValidEmailAddress(String? emailAddress) =>
      _validEmailAddress.hasMatch(emailAddress!);

  bool isValidPassword(String? password) => _validPassword.hasMatch(password!);

  bool isEmpty(String? input) => input!.isEmpty;
}
