import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:yama_vet_admin/data/models/responses/NotificationsResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/dtos/NotificationDto.dart';

class NotificationsProvider extends ChangeNotifier {

  List<NotificationDto> notifications = [];


  Future<void> get(BuildContext? context) async {
    NotificationsResponse notificationsResponse = NotificationsResponse.fromJson(
        await ApiService().get("notification", context: context));
    notifications = notificationsResponse.notifications!;
    log(jsonEncode(notifications));
    notifyListeners();
  }

}
