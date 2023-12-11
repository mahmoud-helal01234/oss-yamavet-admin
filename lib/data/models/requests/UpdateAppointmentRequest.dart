class UpdateAppointmentRequest {
  String? id;
  String? locationId;
  int? price;
  List<PetIds>? petIds;

  UpdateAppointmentRequest({this.id, this.locationId, this.price, this.petIds});

  UpdateAppointmentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    price = json['price'];
    if (json['pet_ids'] != null) {
      petIds = <PetIds>[];
      json['pet_ids'].forEach((v) {
        petIds!.add(new PetIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['price'] = this.price;
    if (this.petIds != null) {
      data['pet_ids'] = this.petIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetIds {
  int? petId;
  List<int>? serviceIds;

  PetIds({this.petId, this.serviceIds});

  PetIds.fromJson(Map<String, dynamic> json) {
    petId = json['pet_id'];
    serviceIds = json['service_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pet_id'] = this.petId;
    data['service_ids'] = this.serviceIds;
    return data;
  }
}
