
class GetOtpRequest {

  String? phone;

  GetOtpRequest({this.phone});

  GetOtpRequest.fromJson(Map<String, dynamic> json) {

    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = this.phone;
    return data;
  }
}
