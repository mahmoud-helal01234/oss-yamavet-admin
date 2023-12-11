class VetsModel {
  final int id;
  final String name;
  final String phone;
  final String role;
  final String img_path;
  final String active;
  String? total_rate;
  VetsModel(
      {required this.id, 
        
        required this.name,
      required this.phone,
      required this.role,
      this.total_rate,
      required this.img_path,
      required this.active});
  factory VetsModel.fromJson(Map<String, dynamic> jsonData) {
    return VetsModel(
        total_rate: jsonData['total_rate'],
        name: jsonData['name'],
        role: jsonData['role'],
        img_path: jsonData['img_path'],
        active: jsonData['active'],
        phone: jsonData['phone'], id: jsonData['id']);
  }
}
