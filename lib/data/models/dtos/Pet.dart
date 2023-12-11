class Pet {
  int? id;
  String? name;
  String? imgPath;
  String? gender;
  String? birthDay;

  int? age;

  Pet(
      {this.id,
        this.name,
        this.imgPath,
        this.gender,
        this.birthDay,

        this.age});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgPath = json['img_path'];
    gender = json['gender'];
    birthDay = json['birth_day'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img_path'] = imgPath;
    data['gender'] = gender;
    data['birth_day'] = birthDay;
    data['age'] = age;
    return data;
  }
}