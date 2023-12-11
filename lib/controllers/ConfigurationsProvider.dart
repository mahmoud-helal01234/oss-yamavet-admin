
import 'package:flutter/cupertino.dart';

import 'package:yama_vet_admin/data/services/ApiService.dart';

import '../data/models/requests/AddReminderRequest.dart';
import '../data/models/responses/ConfigurationsResponse.dart';

class ConfigurationsProvider extends ChangeNotifier {

  Configurations? configurations;

  Future<void> get(BuildContext context) async {

    ConfigurationsResponse configurationsResponse = ConfigurationsResponse.fromJson(await ApiService().get("appointment_configration"));
    configurations = configurationsResponse.data!;
    notifyListeners();
  }


  Future<void> create(BuildContext context,AddReminderRequest addReminderRequest) async {


    Map<String,dynamic> fields = addReminderRequest.toJson();

    await ApiService().post("reminder", fields, context:context,componentName: "Reminder" );

    get(context);

  }





}