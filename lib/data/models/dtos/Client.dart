
import 'Pet.dart';

class Client {
  int? id;
  String? name;
  String? phone;
  String? active;
  List<Pet>? pets;

  Client({this.id, this.name, this.phone, this.active, this.pets});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    active = json['active'];
    if (json['pets'] != null) {
      pets = <Pet>[];
      json['pets'].forEach((v) {
        pets!.add(new Pet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['active'] = this.active;
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
