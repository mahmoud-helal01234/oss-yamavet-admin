import '../dtos/LoggedInUserData.dart';

class LoginResponse {
  bool? status;
  LoggedInUserData? data;
  String? message;

  LoginResponse({this.status, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new LoggedInUserData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

