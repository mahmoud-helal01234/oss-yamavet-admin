import 'dart:convert';
import 'dart:developer';

import 'AppointmentDetailsPetService.dart';
import 'Pet.dart';

class AppointmentDetails {
  Pet? pet;
  List<AppointmentDetailsPetService>? services;

  AppointmentDetails({this.pet, this.services});

  AppointmentDetails.fromJson(Map<String, dynamic> json) {
    if (json['pet'] != null && json['pet'].toString().isNotEmpty) {
      pet = Pet.fromJson((json['pet']));
    }
    if (json['services'] != null) {
      services = <AppointmentDetailsPetService>[];
      json['services'].forEach((v) {
        services!.add(AppointmentDetailsPetService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
