class User {
  String _lastName;
  String _firstName;

  User(this._lastName, this._firstName);
  String get lastName => _lastName;
  String get firstName => _firstName;

  set lastName(String value) {
    if (value.isNotEmpty) {
      _lastName = value;
    }
  }

  set firstName(String value) {
    if (value.isNotEmpty) {
      _firstName = value;
    }
  }
}
