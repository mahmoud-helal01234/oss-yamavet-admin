class Doctor {
  String? name;
  String? imgPath;
  String? totalRate;

  Doctor({this.name, this.imgPath, this.totalRate});

  Doctor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgPath = json['img_path'];
    totalRate = json['total_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img_path'] = imgPath;
    data['total_rate'] = totalRate;
    return data;
  }
}