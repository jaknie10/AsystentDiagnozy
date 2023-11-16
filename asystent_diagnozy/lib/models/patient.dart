import 'package:flutter/foundation.dart' show immutable;

@immutable
class Patient {
  final int id;
  final String name;
  final String surname;
  final String gender;

  const Patient({
    required this.id,
    required this.name,
    required this.surname,
    required this.gender,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "gender": gender,
    };
  }
}
