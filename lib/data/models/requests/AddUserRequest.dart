
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddUserRequest {

  String? name;
  String? phone;
  String? role;
  File? img;
  AddUserRequest(BuildContext context,{ this.name, this.phone, this.role,this.img}){


    // if(img == null) {
    //   QuickAlert.show(
    //     context: context,
    //     type: QuickAlertType.warning,
    //     text: 'Please select an image',
    //     autoCloseDuration: const Duration(seconds: 2),
    //     showConfirmBtn: false,
    //   );
    // }

    if(name == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the name',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if(phone == null){

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the phone',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if(role == null){

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please choose role admin, vet',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

  }

  Map<String, String> toJson() {

    final Map<String, String> data = <String, String>{};

    data['name'] = name!;
    data['phone'] = phone!;
    data['role'] = role!;
    return data;
  }

  Map<String, File> files(){

    Map<String,File> files = <String,File>{};

    if(img != null) {
      files['img_path'] = img!;
    }
    return files;
  }

}