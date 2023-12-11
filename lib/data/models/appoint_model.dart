class AppointModel {
  final int id;
  final String status;
  final int price;
  final String cash;
  List<AppointmentDetailsTwo>? appointmentDetails;

  AppointModel(
      {required this.id,
      this.appointmentDetails,
      required this.status,
      required this.price,
      required this.cash});
  factory AppointModel.fromJson(Map jsonData) {
    return AppointModel(
        appointmentDetails: jsonData['appointment_details'].forEach((v) {
          List appointmentDetails = <AppointmentDetailsTwo>[];
          appointmentDetails.add(new AppointmentDetailsTwo.fromJson(v));
        }),
        id: jsonData['data']['id'],
        status: jsonData['data']['status'],
        price: jsonData['data']['price'],
        cash: jsonData['data']['cash']);
  }
}

class AppointmentDetailsTwo {
  List<PetsTwo>? pets;
  // List<Services>? services;

  AppointmentDetailsTwo({
    this.pets,
  });

  AppointmentDetailsTwo.fromJson(Map<String, dynamic> json) {
    if (json['pets'] != null) {
      pets = <PetsTwo>[];
      json['pets'].forEach((v) {
        pets!.add(new PetsTwo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PetsTwo {
  int? id;
  String? name;
  String? imgPath;
  String? gender;
  String? birthDay;
  int? age;

  PetsTwo(
      {this.id, this.name, this.imgPath, this.gender, this.birthDay, this.age});

  PetsTwo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgPath = json['img_path'];
    gender = json['gender'];
    birthDay = json['birth_day'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img_path'] = this.imgPath;
    data['gender'] = this.gender;
    data['birth_day'] = this.birthDay;
    data['age'] = this.age;
    return data;
  }
}
