class NotificationReminderDTO {
  int? id;
  Null? appointmentId;
  String? description;
  String? appointmentDate;
  int? doctorId;
  int? clientId;
  NotificationReminderDoctor? doctor;

  NotificationReminderDTO(
      {this.id,
        this.appointmentId,
        this.description,
        this.appointmentDate,
        this.doctorId,
        this.clientId,
        this.doctor});

  NotificationReminderDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    description = json['description'];
    appointmentDate = json['appointment_date'];
    doctorId = json['doctor_id'];
    clientId = json['client_id'];
    doctor =
    json['doctor'] != null ? NotificationReminderDoctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['description'] = this.description;
    data['appointment_date'] = this.appointmentDate;
    data['doctor_id'] = this.doctorId;
    data['client_id'] = this.clientId;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class NotificationReminderDoctor {
  int? id;
  String? name;
  String? imgPath;

  NotificationReminderDoctor({this.id, this.name, this.imgPath});

  NotificationReminderDoctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img_path'] = this.imgPath;
    return data;
  }
}
