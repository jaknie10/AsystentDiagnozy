class Lipidogram {
  final int? id;
  final int? patientId;
  final double chol;
  final double ldl;
  final double hdl;
  final double vldl;
  final double tag;
  final String name = "Lipidogram";
  final String datecreated = DateTime.now().toString();

  Lipidogram({
    this.id,
    required this.patientId,
    required this.chol,
    required this.ldl,
    required this.hdl,
    required this.vldl,
    required this.tag,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "patientId": patientId,
      "chol": chol,
      "ldl": ldl,
      "hdl": hdl,
      "vldl": vldl,
      "tag": tag,
      "name": name,
      "datecreated": datecreated,
    };
  }
}
