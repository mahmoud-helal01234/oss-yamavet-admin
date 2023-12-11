class DoctorModel {
  final int id;
  final String name;
  final String img_path;

  DoctorModel({required this.id, required this.name, required this.img_path});
  factory DoctorModel.fromJson(Map<String, dynamic> jsonData) {
    return DoctorModel(
        id: jsonData['status'][0]['id'],
        name: jsonData['status'][0]['name'],
        img_path: jsonData['status'][0]['img_path']);
  }
}
