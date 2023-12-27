class User {
  final int? id;
  String name;
  String surname;
  String login;
  String RSApublicKey;
  String encryptedPrivateKey;
  String saltOne;
  String saltTwo;

  User(
      {this.id,
      required this.name,
      required this.surname,
      required this.login,
      required this.RSApublicKey,
      required this.encryptedPrivateKey,
      required this.saltOne,
      required this.saltTwo});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      'surname': surname,
      'login': login,
      'RSApublicKey': RSApublicKey,
      'encyrptedPrivateKey': encryptedPrivateKey,
      'saltOne': saltOne,
      'saltTwo': saltTwo,
    };
  }
}
