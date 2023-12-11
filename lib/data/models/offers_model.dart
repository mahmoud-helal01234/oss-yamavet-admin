class OffersModel {
  final int id;
  final String img_path;
  String? link;

  OffersModel({required this.id, required this.img_path, this.link});
  factory OffersModel.fromJson(Map<String, dynamic> jsonData) {
    return OffersModel(
        id: jsonData['id'],
        img_path: jsonData['img_path'],
        link: jsonData['link']);
  }
}
