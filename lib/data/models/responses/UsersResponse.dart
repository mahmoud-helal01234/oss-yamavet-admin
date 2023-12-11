import '../dtos/User.dart';

class UsersResponse {
  bool? status;
  List<User>? users;
  String? message;

  UsersResponse({this.status, this.users, this.message});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      users = <User>[];
      json['data'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (users != null) {
      data['data'] = users!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}


