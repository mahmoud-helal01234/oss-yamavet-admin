
import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:yama_vet_admin/data/models/requests/AddUserRequest.dart';

import '../core/utils/colors.dart';
import '../data/models/dtos/User.dart';
import '../data/models/requests/UpdateUserRequest.dart';
import '../data/models/responses/UsersResponse.dart';
import '../data/services/ApiService.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];

  void replace(List<User> newUsers) {
    users = newUsers;
    notifyListeners();
  }

  Future<void> get(BuildContext? context ) async {
    UsersResponse usersResponse = UsersResponse.fromJson(await ApiService()
        .get("user", context: context, componentName: "User"));
    users = usersResponse.users!;
    notifyListeners();
  }

  Future<void> create(
      BuildContext context, AddUserRequest addUserRequest) async {
    await ApiService().postWithFiles(
        "user", addUserRequest.toJson(), addUserRequest.files(),
        context: context, componentName: "User");

    Navigator.pop(context);
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'User Created Successfully',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: true,
        confirmBtnColor: primary
    );
    get(context);
  }

  Future<void> delete(BuildContext context, int userIndex) async {
    await ApiService().delete("user", users[userIndex].id!,
        context: context, componentName: "User");
    users.removeAt(userIndex);
    notifyListeners();

  }

  Future update(
      BuildContext context, UpdateUserRequest updateUserRequest) async {
    await ApiService().postWithFiles(
        "user/update", updateUserRequest.toJson(), updateUserRequest.files(),
        context: context, componentName: "User", operationName: "Updated");

    get(context);
  }
}
