import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/data/models/requests/AddUserRequest.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';

import '../core/utils/colors.dart';
import '../data/models/dtos/User.dart';
import '../data/models/requests/LoginRequest.dart';
import '../data/models/requests/UpdateServiceRequest.dart';
import '../data/models/requests/UpdateUserRequest.dart';
import '../data/models/responses/LoginResponse.dart';
import '../data/models/responses/UsersResponse.dart';
import '../data/services/ApiService.dart';

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

  Future<void> login(
      BuildContext context, LoginRequest loginRequest) async {
    LoginResponse loginResponse = LoginResponse.fromJson(await ApiService().post(
        "login", loginRequest.toJson(),
        context: context, componentName: "Login"));
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString('token', loginResponse.data!.token!);

    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Logged in Successfully',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: true,
        confirmBtnColor: primary
    );
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
}
