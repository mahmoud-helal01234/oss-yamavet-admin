class NotificationAppointmentDTO {
  int? id;
  int? active;
  String? paymentType;
  String? invoiceId;
  String? paymentId;
  int? paymentStatus;
  Null? paymentUrl;
  String? type;
  String? content;
  int? appointmentNumber;
  int? clientId;
  int? locationId;
  int? price;
  String? status;
  String? cash;
  int? doctorId;
  String? doctorRate;
  String? appointmentRate;
  String? rateDescription;
  String? description;
  NotificationAppointmentDoctorDTO? doctor;

  NotificationAppointmentDTO(
      {this.id,
        this.active,
        this.paymentType,
        this.invoiceId,
        this.paymentId,
        this.paymentStatus,
        this.paymentUrl,
        this.type,
        this.content,
        this.appointmentNumber,
        this.clientId,
        this.locationId,
        this.price,
        this.status,
        this.cash,
        this.doctorId,
        this.doctorRate,
        this.appointmentRate,
        this.rateDescription,
        this.description,
        this.doctor});

  NotificationAppointmentDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    paymentType = json['payment_type'];
    invoiceId = json['invoice_id'];
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    paymentUrl = json['payment_url'];
    type = json['type'];
    content = json['content'];
    appointmentNumber = json['appointment_number'];
    clientId = json['client_id'];
    locationId = json['location_id'];
    price = json['price'];
    status = json['status'];
    cash = json['cash'];
    doctorId = json['doctor_id'];
    doctorRate = json['doctor_rate'];
    appointmentRate = json['appointment_rate'];
    rateDescription = json['rate_description'];
    description = json['description'];
    doctor =
    json['doctor'] != null ? NotificationAppointmentDoctorDTO.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['active'] = this.active;
    data['payment_type'] = this.paymentType;
    data['invoice_id'] = this.invoiceId;
    data['payment_id'] = this.paymentId;
    data['payment_status'] = this.paymentStatus;
    data['payment_url'] = this.paymentUrl;
    data['type'] = this.type;
    data['content'] = this.content;
    data['appointment_number'] = this.appointmentNumber;
    data['client_id'] = this.clientId;
    data['location_id'] = this.locationId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['cash'] = this.cash;
    data['doctor_id'] = this.doctorId;
    data['doctor_rate'] = this.doctorRate;
    data['appointment_rate'] = this.appointmentRate;
    data['rate_description'] = this.rateDescription;
    data['description'] = this.description;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class NotificationAppointmentDoctorDTO {
  int? id;
  String? name;
  String? phone;
  String? role;
  String? imgPath;
  int? appointmentNumber;
  int? totalRate;

  NotificationAppointmentDoctorDTO(
      {this.id,
        this.name,
        this.phone,
        this.role,
        this.imgPath,
        this.appointmentNumber,
        this.totalRate,
      });

  NotificationAppointmentDoctorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    imgPath = json['img_path'];
    appointmentNumber = json['appointment_number'];
    totalRate = json['total_rate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['img_path'] = this.imgPath;
    data['appointment_number'] = this.appointmentNumber;
    data['total_rate'] = this.totalRate;

    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? phone;

  Client(
      {this.id, this.name, this.phone});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

