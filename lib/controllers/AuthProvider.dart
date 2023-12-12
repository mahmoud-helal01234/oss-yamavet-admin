import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/data/models/requests/AddUserRequest.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';
import 'package:yama_vet_admin/screens/Auth/verify.dart';

import '../core/utils/colors.dart';
import '../core/utils/strings.dart';
import '../data/models/dtos/User.dart';
import '../data/models/requests/LoginRequest.dart';
import '../data/models/requests/UpdateServiceRequest.dart';
import '../data/models/requests/UpdateUserRequest.dart';
import '../data/models/responses/LoginResponse.dart';
import '../data/models/responses/UsersResponse.dart';
import '../data/services/ApiService.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  LoginResponse? loginResponse;

  // void replace(List<User> newUsers) {
  //   users = newUsers;
  //   notifyListeners();
  // }

  // Future<void> get(BuildContext context) async {
  //   UsersResponse usersResponse = UsersResponse.fromJson(await ApiService()
  //       .get("user", context: context, componentName: "User"));
  //   users = usersResponse.users!;
  //   notifyListeners();
  // }

  Future<void> login(BuildContext context, LoginRequest loginRequest) async {
    http.Response response =
    await http.post(Uri.parse(loginLink), body: {}, headers: {
      "api-token": "yama-vets",
    });

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('sucess');
      if (data['status'] == true) {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

        Navigator.pushNamed(context, verify);
      } else {
        print('fail to load data');
        print(data);
        return;
      }
    } else {
      print(response.statusCode);
    }
    // LoginResponse loginResponse = LoginResponse.fromJson(await ApiService()
    //     .postNotAuth("login", loginRequest.toJson(),
    //         context: context, componentName: "Login"));
    // if (loginResponse.status == true) {
    //   log("response:" + loginResponse.toJson().toString());
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //
    //   sharedPreferences.setString('token', loginResponse.data!.token!);
    //   sharedPreferences.setString('role', loginResponse.data!.role!);
    //   // QuickAlert.show(
    //   //     context: context,
    //   //     type: QuickAlertType.success,
    //   //     text: 'Logged in Successfully',
    //   //     autoCloseDuration: const Duration(seconds: 2),
    //   //     showConfirmBtn: true,
    //   //     confirmBtnColor: primary);
    //   Navigator.pushNamed(context, verify);
    // } else {
    //   QuickAlert.show(
    //       context: context,
    //       type: QuickAlertType.success,
    //       text: loginResponse.message,
    //       autoCloseDuration: const Duration(seconds: 2),
    //       showConfirmBtn: true,
    //       confirmBtnColor: primary);
    //
    // }
  }

  // Future<void> delete(BuildContext context, int userIndex) async {
  //   await ApiService().delete("user", users[userIndex].id!,
  //       context: context, componentName: "User");
  //   users.removeAt(userIndex);
  //   notifyListeners();
  //
  // }

  // Future update(
  //     BuildContext context, UpdateUserRequest updateUserRequest) async {
  //   await ApiService().postWithFiles(
  //       "user/update", updateUserRequest.toJson(), updateUserRequest.files(),
  //       context: context, componentName: "User", operationName: "Updated");
  //
  //   get(context);
  // }

  loginWogood(BuildContext context,String phone,String deviceId) async {
    if (context != null) {
      context.loaderOverlay.show();
    }
try {
  http.Response response = await http.post(Uri.parse(loginLink), body: {
    "phone": phone,
    "device_id": deviceId,
  }, headers: {
    "api-token": "yama-vets",
  });
  Map<String, dynamic> data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (data['status'] == true) {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data['data']['token']);
      if (context != null) {
        context.loaderOverlay.hide();
      }
      Navigator.pushNamed(context, verify);
    } else {
      print('fail to load data');
      print(data);
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  } else {
    print(response.statusCode);
    if (context != null) {
      context.loaderOverlay.hide();
    }
  }
}catch(ex){
  if (context != null) {
    context.loaderOverlay.hide();
  }
}
  }
}
