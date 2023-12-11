import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddReminderRequest {

  int? clientId;
  String? appointmentDate;
  String? description;

  AddReminderRequest(BuildContext context,
      {required this.clientId,
      required this.appointmentDate,
      required this.description}) {
    if (clientId == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please choose client',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if (appointmentDate == null) {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the date',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if (description == null) {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the description',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }
  }



  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['appointment_date'] = appointmentDate;
    data['description'] = description;
    return data;
  }
}
