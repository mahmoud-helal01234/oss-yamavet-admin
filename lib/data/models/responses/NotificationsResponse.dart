import '../dtos/NotificationAppointmentDTO.dart';
import '../dtos/NotificationDto.dart';
import '../dtos/NotificationReminderDTO.dart';

class NotificationsResponse {

  bool? status;
  List<NotificationDTO>? notifications;
  String? message;

  NotificationsResponse({this.status, this.notifications, this.message});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      notifications = <NotificationDTO>[];
      json['data'].forEach((v) {
        notifications!.add(NotificationDTO.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (notifications != null) {
      data['data'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

