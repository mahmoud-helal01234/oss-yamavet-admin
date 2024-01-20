import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:yama_vet_admin/data/models/dtos/Appointment.dart';

import 'package:yama_vet_admin/data/models/responses/NotificationsResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/dtos/NotificationDto.dart';
import '../data/models/dtos/Reminder.dart';

class NotificationsProvider extends ChangeNotifier {

  List<NotificationDTO> notifications = [];
  bool newNotificationStatus = false;
  setNewNotificationStatus(bool status){
    newNotificationStatus = status;
    notifyListeners();
  }
  Future<void> get(BuildContext? context) async {
    NotificationsResponse notificationsResponse = NotificationsResponse.fromJson(
        await ApiService().get("notification", context: context));
    notifications = notificationsResponse.notifications!;
    log("notificationsApiResponse: ${notificationsResponse.toJson()}");
    notifyListeners();
  }

  handleNotificationWhenAppInBackground(context){
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("Notification opened: ${result.notification.body}");
      setNewNotificationStatus(true);

      // Navigate to NotificationScreen
      // navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => const NotificationScreen()));
    });

    // handle when notification received
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
      log("background:" + event.notification.title.toString());


      setNewNotificationStatus(true);
    });
  }
}
