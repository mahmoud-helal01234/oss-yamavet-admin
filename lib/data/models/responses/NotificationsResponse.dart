import '../dtos/NotificationDto.dart';

class NotificationsResponse {
  bool? status;
  List<NotificationDto>? notifications;


  NotificationsResponse({this.status, this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      notifications = <NotificationDto>[];
      json['data'].forEach((v) {
        notifications!.add(NotificationDto.fromJson(v));
      });
    }

  }

}
