import 'Client.dart';

class Reminder {

  int? id;
  String? description;
  String? appointmentDate;
  Client? client;

  Reminder(
      {this.id,
        this.description,
        this.appointmentDate,
        this.client
      });

  Reminder.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    description = json['description'];
    appointmentDate = json['appointment_date'];
    client =
    json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['appointment_date'] = appointmentDate;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}