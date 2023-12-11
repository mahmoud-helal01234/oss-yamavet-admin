import 'Client.dart';

class Reminder {

  int? id;
  int? appointmentId;
  String? description;
  String? appointmentDate;
  int? doctorId;
  int? clientId;
  Client? client;

  Reminder(
      {this.id,
        this.appointmentId,
        this.description,
        this.appointmentDate,
        this.doctorId,
        this.clientId,
        this.client});

  Reminder.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    appointmentId = json['appointment_id'];
    description = json['description'];
    appointmentDate = json['appointment_date'];
    doctorId = json['doctor_id'];
    clientId = json['client_id'];
    client =
    json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appointment_id'] = appointmentId;
    data['description'] = description;
    data['appointment_date'] = appointmentDate;
    data['doctor_id'] = doctorId;
    data['client_id'] = clientId;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}