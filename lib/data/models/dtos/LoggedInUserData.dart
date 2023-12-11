class LoggedInUserData {
  int? id;
  String? name;
  String? phone;
  String? role;
  String? imgPath;
  int? appointmentNumber;
  int? totalRate;
  String? active;
  String? lang;
  String? deviceId;
  Null? deletedAt;
  String? token;

  LoggedInUserData(
      {this.id,
        this.name,
        this.phone,
        this.role,
        this.imgPath,
        this.appointmentNumber,
        this.totalRate,
        this.active,
        this.lang,
        this.deviceId,
        this.deletedAt,
        this.token});

  LoggedInUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    imgPath = json['img_path'];
    appointmentNumber = json['appointment_number'];
    totalRate = json['total_rate'];
    active = json['active'];
    lang = json['lang'];
    deviceId = json['device_id'];
    deletedAt = json['deleted_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['img_path'] = this.imgPath;
    data['appointment_number'] = this.appointmentNumber;
    data['total_rate'] = this.totalRate;
    data['active'] = this.active;
    data['lang'] = this.lang;
    data['device_id'] = this.deviceId;
    data['deleted_at'] = this.deletedAt;
    data['token'] = this.token;
    return data;
  }
}
