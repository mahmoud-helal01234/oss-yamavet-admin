
import 'AppointmentDetails.dart';
import 'ClientLocation.dart';
import 'Doctor.dart';

class Appointment {
  int? id;
  String? type;
  String? content;
  int? appointmentNumber;
  String? cash;
  int? price;
  String? status;
  double? doctorRate;
  double? appointmentRate;
  String? rateDescription;
  String? day;
  List<String>? petsImages;
  List<AppointmentDetails>? appointmentDetails;
  ClientLocation? clientLocation;
  Doctor? doctor;

  Appointment(
      {this.id,
        this.type,
        this.content,
        this.appointmentNumber,
        this.cash,
        this.price,
        this.status,
        this.doctorRate,
        this.appointmentRate,
        this.rateDescription,
        this.day,
        this.petsImages,
        this.appointmentDetails,
        this.clientLocation,
        this.doctor});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    appointmentNumber = json['appointment_number'];
    cash = json['cash'];
    price = json['price'];
    status = json['status'];
    // doctorRate = json['doctor_rate'];
    // appointmentRate = json['appointment_rate'];
    rateDescription = json['rate_description'];
    day = json['day'];
    petsImages = json['petsImages'].cast<String>();
    if (json['appointment_details'] != null) {
      appointmentDetails = <AppointmentDetails>[];
      json['appointment_details'].forEach((v) {
        appointmentDetails!.add(AppointmentDetails.fromJson(v));
      });
    }
    clientLocation = json['client_location'] != null
        ? ClientLocation.fromJson(json['client_location'])
        : null;
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['content'] = content;
    data['appointment_number'] = appointmentNumber;
    data['cash'] = cash;
    data['price'] = price;
    data['status'] = status;
    // data['doctor_rate'] = this.doctorRate;
    data['appointment_rate'] = appointmentRate;
    data['rate_description'] = rateDescription;
    data['day'] = day;
    data['petsImages'] = petsImages;
    if (appointmentDetails != null) {
      data['appointment_details'] =
          appointmentDetails!.map((v) => v.toJson()).toList();
    }
    if (clientLocation != null) {
      data['client_location'] = clientLocation!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}