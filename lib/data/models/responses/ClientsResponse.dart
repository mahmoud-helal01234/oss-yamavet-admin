
import '../dtos/Client.dart';

class ClientsResponse {
  bool? status;
  List<Client>? clients;
  String? message;

  ClientsResponse({this.status, this.clients, this.message});

  ClientsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      clients = <Client>[];
      json['data'].forEach((v) {
        clients!.add(new Client.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.clients != null) {
      data['data'] = this.clients!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}