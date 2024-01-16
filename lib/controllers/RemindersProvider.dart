import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';

import 'package:yama_vet_admin/data/models/responses/RemindersResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/dtos/Reminder.dart';
import '../data/models/requests/AddReminderRequest.dart';

class RemindersProvider extends ChangeNotifier {
  List<Reminder> reminders = [];
  int? selectedClientIndex;
  AddReminderRequest? addReminderRequest;

  void changeAddReminderRequest(
      {int? clientId, String? appointmentDate, String? description}) {
    if (addReminderRequest == null) {
      addReminderRequest = AddReminderRequest.basic();
    }

    if (clientId != null) {
      addReminderRequest!.clientId = clientId!;
    }


    if (description != null) {
      addReminderRequest!.description = description!;
    }

    if (appointmentDate != null) {
      addReminderRequest!.appointmentDate = appointmentDate!;
    }
    notifyListeners();

  }

  void changeSelectedClient(BuildContext context, selectedClientIndex) async {
    this.selectedClientIndex = selectedClientIndex;

    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> get(BuildContext? context) async {
    RemindersResponse remindersResponse = RemindersResponse.fromJson(
        await ApiService().get("reminder", context: context));
    reminders = remindersResponse.reminders!;
    log(jsonEncode(reminders));
    notifyListeners();
  }

  Future<void> create(
      BuildContext context, AddReminderRequest addReminderRequest) async {

    log(jsonEncode(addReminderRequest));

    Map<String, dynamic> fields = addReminderRequest.toJson();
    await ApiService()
        .post("reminder", fields, context: context, componentName: "Reminder");

    get(null);
  }

  Future<void> delete(BuildContext context, int reminderIndex) async {
    await ApiService().delete("reminder", reminders[reminderIndex].id!,
        context: context, componentName: "Reminder");
    reminders.removeAt(reminderIndex);
    notifyListeners();
  }
}
