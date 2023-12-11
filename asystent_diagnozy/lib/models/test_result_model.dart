import 'dart:convert';

class TestResult {
  final int? id;
  final int patientId;
  final String testType;
  final DateTime createdAt;
  Map<dynamic, dynamic> results;

  TestResult({
    this.id,
    required this.patientId,
    required this.testType,
    required this.createdAt,
    required this.results,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "patientId": patientId,
      "testType": testType,
      "createdAt": createdAt.toString(),
      "results": json.encode(results),
    };
  }
}
