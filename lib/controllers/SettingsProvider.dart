import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yama_vet_admin/data/models/responses/RemindersResponse.dart';
import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../core/utils/strings.dart';
import '../data/models/dtos/Reminder.dart';
import '../data/models/requests/AddReminderRequest.dart';

class SettingsProvider extends ChangeNotifier {
  String lang = 'en';

  String? role;

  String? token;

  Future<void> initUserData(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    token = sharedPreferences.getString('token');
    role = sharedPreferences.getString('role');

    if (token != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(dash, (Route<dynamic> route) => false);
    } else {
      Navigator.pushReplacementNamed(context, login);
    }
    notifyListeners();
  }

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void changeRole(String newRole) {
    role = newRole;
    notifyListeners();
  }

  void changeLang(String newLang) {
    lang = newLang;
    notifyListeners();
  }
}
