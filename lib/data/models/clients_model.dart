class ClientsModel {
  final int id;
  final String name;
  final String phone;
  final String active;

  ClientsModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.active});

  factory ClientsModel.fromJson(Map<String, dynamic> jsonData) {
    return ClientsModel(
        id: jsonData['id'],
        name: jsonData['name'],
        phone: jsonData['phone'],
        active: jsonData['active']);
  }
}
