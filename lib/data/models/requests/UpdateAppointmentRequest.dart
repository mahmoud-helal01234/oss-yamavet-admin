import 'dart:collection';

import 'package:yama_vet_admin/data/models/responses/CategoriesResponse.dart';

import '../dtos/Pet.dart';
import '../dtos/Service.dart';

class UpdateAppointmentRequest {
  String? id;
  List<PetIds>? petIds;

  UpdateAppointmentRequest({this.id,  this.petIds});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    if (this.petIds != null) {
      data['pet_ids'] = this.petIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetIds {
  int? petId;
  Pet? pet;
  HashMap<int,Service>? services;

  PetIds({this.petId,this.pet, this.services});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pet_id'] = petId;
    data['service_ids'] = services!.keys.toList();
    return data;
  }
}
