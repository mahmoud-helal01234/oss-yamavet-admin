
import 'package:flutter/cupertino.dart';

import 'package:yama_vet_admin/data/models/responses/RemindersResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/dtos/Reminder.dart';
import '../data/models/requests/AddReminderRequest.dart';

class SettingsProvider extends ChangeNotifier {

  String lang = 'en';

  void changeLang(String newLang){
    lang = newLang;
    notifyListeners();
  }


}