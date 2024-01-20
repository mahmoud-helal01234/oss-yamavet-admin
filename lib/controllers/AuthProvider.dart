import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/screens/Auth/verify.dart';
import '../core/utils/colors.dart';
import '../core/utils/strings.dart';
import '../data/models/requests/GetOtpRequest.dart';
import '../data/models/requests/LoginRequest.dart';
import '../data/models/responses/LoginResponse.dart';
import 'package:http/http.dart' as http;

import '../data/services/ApiService.dart';
import 'SettingsProvider.dart';

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

  Future<void> getOTP(BuildContext context, GetOtpRequest getOtpRequest) async {
    Map<String, dynamic> data = await ApiService()
        .postNotAuth('sendOtp', getOtpRequest.toJson(), context: context);

    if (data['status'] == true) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyScreen(
              phone: getOtpRequest.phone!,
              otpCode: data['data']['otp_code'].toString())));
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Otp sent to your phone".tr(),
          autoCloseDuration: const Duration(seconds: 2),
          showConfirmBtn: true,
          confirmBtnColor: primary);
    } else {
      print('fail to load data');
      print(data);
      return;
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

  Future<void> login(BuildContext context, LoginRequest loginRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loginRequest.deviceId = sharedPreferences.getString("device_token")!;

    Map<String, dynamic> data = await ApiService()
        .postNotAuth('login', loginRequest.toJson(), context: context);

    if (data['status'] == true) {

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString('token', data['data']['token']);
      sharedPreferences.setString('role', data['data']['role']);
      Provider.of<SettingsProvider>(context, listen: false)
          .changeRole(data['data']['role']);
      Provider.of<SettingsProvider>(context, listen: false)
          .setToken(data['data']['token']);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(dash, (Route<dynamic> route) => false);

    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Wrong OTP".tr(),
          autoCloseDuration: const Duration(seconds: 2),
          showConfirmBtn: true,
          confirmBtnColor: primary);
      print('fail to load data');
      print(data);
      return;
    }
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

  loginWogood(BuildContext context, String phone) async {
    if (context != null) {
      context.loaderOverlay.show();
    }

    try {
      String deviceId;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      deviceId = sharedPreferences.getString("device_token")!;
      print("device_id " + deviceId);
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
          sharedPreferences.setString('role', data['data']['role']);
          Provider.of<SettingsProvider>(context, listen: false)
              .changeRole(data['data']['role']);
          Provider.of<SettingsProvider>(context, listen: false)
              .setToken(data['data']['token']);
          if (context != null) {
            context.loaderOverlay.hide();
          }
          Navigator.pushNamed(context, verify);
        } else {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: data['data']['msg'],
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true,
              confirmBtnColor: primary);
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
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  }
}
