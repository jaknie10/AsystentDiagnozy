// import 'package:flutter/foundation.dart' show immutable;

// @immutable
class Patient {
  final int? id;
  final String name;
  final String surname;
  final String gender;
  final String birthDate;
  final String datecreated = DateTime.now().toString();

  Patient({
    this.id,
    required this.name,
    required this.surname,
    required this.gender,
    required this.birthDate,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "gender": gender,
      'birthdate': birthDate,
      "datecreated": datecreated
    };
  }
}
