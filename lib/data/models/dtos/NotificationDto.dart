import 'NotificationAppointmentDTO.dart';
import 'NotificationReminderDTO.dart';

class NotificationDTO {
  String? type;
  int? doctorId;
  int? clientId;
  int? appointmentId;
  int? reminderId;
  NotificationAppointmentDTO? appointment;
  Client? client;
  NotificationReminderDTO? reminder;

  NotificationDTO(
      {this.type,
        this.doctorId,
        this.clientId,
        this.appointmentId,
        this.reminderId,
        this.appointment,
        this.client,
        this.reminder});

  NotificationDTO.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    doctorId = json['doctor_id'];
    clientId = json['client_id'];
    appointmentId = json['appointment_id'];
    reminderId = json['reminder_id'];
    appointment = json['appointment'] != null
        ? new NotificationAppointmentDTO.fromJson(json['appointment'])
        : null;
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    reminder = json['reminder'] != null
        ? new NotificationReminderDTO.fromJson(json['reminder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['doctor_id'] = this.doctorId;
    data['client_id'] = this.clientId;
    data['appointment_id'] = this.appointmentId;
    data['reminder_id'] = this.reminderId;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.reminder != null) {
      data['reminder'] = this.reminder!.toJson();
    }
    return data;
  }
}

