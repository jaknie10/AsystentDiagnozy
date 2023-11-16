import 'package:flutter/foundation.dart' show immutable;

@immutable
class Pacjent {
  final int id;
  final String name;
  final String surname;
  final String sex;

  const Pacjent({
    required this.id,
    required this.name,
    required this.surname,
    required this.sex,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "sex": sex,
    };
  }
}
