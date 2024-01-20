
class LoginRequest {
  String? phone;
  String? otpCode;
  String? deviceId;

  LoginRequest({this.phone, this.deviceId, this.otpCode});

  LoginRequest.fromJson(Map<String, dynamic> json) {

    phone = json['phone'];
    deviceId = json['device_id'];
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['device_id'] = deviceId;
    data['otp_code'] = otpCode;
    return data;
  }
}
