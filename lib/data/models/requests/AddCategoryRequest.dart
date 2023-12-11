
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddCategoryRequest {

  String? nameAr;
  String? nameEn;
  File? file;

  AddCategoryRequest(BuildContext context,{ this.file, this.nameAr, this.nameEn}){

    if(file == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please select an image',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if(nameAr == null){

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the name in arabic',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if(nameEn == null){

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the name in english',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

  }

  AddCategoryRequest.fromJson(Map<String, dynamic> json) {

    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    return data;
  }
}