import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

import '../../core/utils/strings.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  ApiService._internal();

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token")!;
  }

  Future<dynamic?> get(String endPoint,
      {BuildContext? context, String componentName = ""}) async {
    try {
      if (context != null) {
        context.loaderOverlay.show();
      }
      String token = await getToken();
      http.Response response = await http.get(Uri.parse('$baseApiUrl$endPoint'),
          headers: {"api-token": "yama-vets", "Authorization": "Bearer$token"});
      log("response body:" + response.body);
      log("response status code:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        if (context != null) {
          context.loaderOverlay.hide();
        }
        return jsonDecode(response.body);
      } else {
        if (context != null) {
          context.loaderOverlay.hide();
        }
        throw Exception('Failed to fetch items');
      }
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
      throw Exception('Failed to fetch items');
    }
  }

  Future<dynamic?> getAction(String endPoint,
      {BuildContext? context,
      String componentName = "",
      String actionName = ""}) async {
    try {
      if (context != null) {
        context.loaderOverlay.show();
      }

      String token = await getToken();
      http.Response response = await http.get(Uri.parse('$baseApiUrl$endPoint'),
          headers: {"api-token": "yama-vets", "Authorization": "Bearer$token"});
      log("response body:" + response.body);
      log("response status code:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        if (context != null) {
          if (context != null) {
            context.loaderOverlay.hide();
          }
          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: '$componentName $actionName Successfully',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true,
              confirmBtnColor: primary);
        }
      } else {
        if (context != null) {
          context.loaderOverlay.hide();
        }

        throw Exception('Failed to add item');
      }
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }

      throw Exception('Failed to fetch items');
    } finally {
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  }

  Future<dynamic> postNotAuth(String endPoint, Map<String, dynamic> itemData,
      {BuildContext? context,
        String componentName = "",
        String operationName = "Logged in"}) async {
    try {

      if (context != null) {
        context.loaderOverlay.show();
      }


      final response = await http.post(
        Uri.parse('$baseApiUrl$endPoint'),
        body: jsonEncode(itemData),
        headers: {
          'Content-Type': 'application/json',
          'api-token': 'yama-vets'
        },
      );
      log("response body:" + response.body);
      log("response status code:" + response.statusCode.toString());

      if (response.statusCode == 200) {

        if (context != null) {
          context.loaderOverlay.hide();
          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: '$componentName $operationName Successfully',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true,
              confirmBtnColor: primary);
          return jsonDecode(response.body);
        } else {
          if (context != null) {
            context.loaderOverlay.hide();
          }

          throw Exception('Failed to add item');
        }
      }
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> itemData,
      {BuildContext? context,
      String componentName = "",
      String operationName = "Added"}) async {
    try {

      if (context != null) {
        context.loaderOverlay.show();
      }

      String token = await getToken();

      final response = await http.post(
        Uri.parse('$baseApiUrl$endPoint'),
        body: jsonEncode(itemData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer${token}',
          'api-token': 'yama-vets'
        },
      );
      log("response body:" + response.body);
      log("response status code:" + response.statusCode.toString());

      if (response.statusCode == 200) {

        if (context != null) {
          context.loaderOverlay.hide();
          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: '$componentName $operationName Successfully',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true,
              confirmBtnColor: primary);
          return jsonDecode(response.body);
        } else {
          if (context != null) {
            context.loaderOverlay.hide();
          }

          throw Exception('Failed to add item');
        }
      }
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  }



  Future<void> postWithFiles(String endPoint, Map<String, String> itemData,
      Map<String, File> filesData,
      {BuildContext? context,
      String componentName = "",
      String operationName = "Added"}) async {
    try {
      if (context != null) {
        context.loaderOverlay.show();
      }
      String token = await getToken();

      var request =
          http.MultipartRequest("POST", Uri.parse('$baseApiUrl$endPoint'));

      request.headers['api-token'] = 'yama-vets';
      request.fields.addAll(itemData);
      request.headers['Authorization'] = 'Bearer${token}';
      filesData.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(
          key,
          value!.path,
        ));
      });

      return await request.send().then((response) async {
        log("response body:" + await response.stream.bytesToString());
        log("response status code:" + response.statusCode.toString());
        if (response.statusCode == 200) {
          if (context != null) {
            context.loaderOverlay.hide();
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: '$componentName $operationName Successfully',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: true,
                confirmBtnColor: primary);
          }
        } else {
          if (context != null) {
            context.loaderOverlay.hide();
          }
          print("error-----${await response.stream.bytesToString()}");
          throw Exception("error adding");
        }
      });
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
      throw Exception("error adding ${ex.toString()}");
    }
  }

  // Future<void> put(String endPoint, Map<String, dynamic> updatedData) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse('$baseApiUrl$endPoint'),
  //       body: jsonEncode(updatedData),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to edit item');
  //     }
  //   } catch (ex) {
  //     return;
  //   }
  // }

  Future<void> delete(String endPoint, int itemId,
      {BuildContext? context, String componentName = ""}) async {
    try {
      if (context != null) {
        context.loaderOverlay.show();
      }

      String token = await getToken();

      var response = await http.delete(
          Uri.parse('$baseApiUrl$endPoint/$itemId'),
          headers: {"api-token": "yama-vets", "Authorization": "Bearer$token"});
      log("response body:" + response.body);
      log("response status code:" + response.statusCode.toString());

      log('$baseApiUrl$endPoint/$itemId');
      if (response.statusCode == 200) {
        if (context != null) {
          context.loaderOverlay.hide();

          QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: '$componentName Deleted Successfully',
              autoCloseDuration: const Duration(seconds: 3),
              showConfirmBtn: true,
              confirmBtnColor: primary);
        }
      } else {
        if (context != null) {
          context.loaderOverlay.hide();

          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: '$componentName not deleted, Try again later',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: true,
              confirmBtnColor: primary);
        }

        throw Exception('Failed to delete item');
      }
    } catch (ex) {
      if (context != null) {
        context.loaderOverlay.hide();
      }
    }
  }
}
