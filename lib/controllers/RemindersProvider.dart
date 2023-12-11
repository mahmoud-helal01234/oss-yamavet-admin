
import 'package:flutter/cupertino.dart';

import 'package:yama_vet_admin/data/models/responses/RemindersResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/dtos/Reminder.dart';
import '../data/models/requests/AddReminderRequest.dart';

class RemindersProvider extends ChangeNotifier {

  List<Reminder> reminders = [];

  Future<void> get(BuildContext context) async {

    RemindersResponse remindersResponse = RemindersResponse.fromJson(await ApiService().get("reminder"));
    reminders = remindersResponse.reminders!;
    notifyListeners();
  }


  Future<void> create(BuildContext context,AddReminderRequest addReminderRequest) async {


    Map<String,dynamic> fields = addReminderRequest.toJson();

    await ApiService().post("reminder", fields, context:context,componentName: "Reminder" );

    get(context);

  }

  Future<void> delete(BuildContext context,int reminderIndex) async {

    await ApiService().delete("reminder",reminders[reminderIndex].id!,context: context,componentName: "Reminder");
    reminders.removeAt(reminderIndex);
    notifyListeners();
    Navigator.pop(context);
  }



}