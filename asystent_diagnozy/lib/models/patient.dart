import 'package:flutter/foundation.dart' show immutable;

@immutable
class Patient {
  final int id;
  final String name;
  final String surname;
  final String gender;
  final String birthDate;

  const Patient(
      {required this.id, required this.name, required this.surname, required this.gender, required this.birthDate});
  Map<String, dynamic> toMap() {
    return {"name": name, "surname": surname, "gender": gender, 'birthdate': birthDate};
  }
}
