class Patient {
  final int? id;
  final String name;
  final String surname;
  final String gender;
  final DateTime birthdate;
  final DateTime createdAt;

  Patient({
    this.id,
    required this.name,
    required this.surname,
    required this.gender,
    required this.birthdate,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "gender": gender,
      'birthdate': birthdate.toString(),
      "createdAt": createdAt.toString()
    };
  }
}
