class User {
  final int? id;
  String name;
  String surname;
  String login;
  String rsaPublicKey;
  String encryptedPrivateKey;
  String saltOne;
  String saltTwo;

  User(
      {this.id,
      required this.name,
      required this.surname,
      required this.login,
      required this.rsaPublicKey,
      required this.encryptedPrivateKey,
      required this.saltOne,
      required this.saltTwo});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      'surname': surname,
      'login': login,
      'RSApublicKey': rsaPublicKey,
      'encyrptedPrivateKey': encryptedPrivateKey,
      'saltOne': saltOne,
      'saltTwo': saltTwo,
    };
  }
}
