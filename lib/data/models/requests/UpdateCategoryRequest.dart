
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UpdateCategoryRequest {

  int? id;
  String? nameAr;
  String? nameEn;
  File? file;

  UpdateCategoryRequest(BuildContext context,{ this.id,this.file, this.nameAr, this.nameEn}){

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

  UpdateCategoryRequest.fromJson(Map<String, dynamic> json) {

    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, String> toJson() {

    final Map<String, String> data = <String, String>{};
    data['id'] = id.toString();
    data['name_ar'] = nameAr!;
    data['name_en'] = nameEn!;
    return data;
  }

  Map<String, File> files(){

    Map<String,File> files = <String,File>{};

    if(file != null) {
      files['img_path'] = file!;
    }
    return files;
  }
}