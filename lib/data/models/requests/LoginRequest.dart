class LoginRequest {
  String? phone;
  String? deviceId;

  LoginRequest({this.phone, this.deviceId});

  LoginRequest.fromJson(Map<String, dynamic> json) {

    phone = json['phone'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['device_id'] = this.deviceId;
    return data;
  }
}
