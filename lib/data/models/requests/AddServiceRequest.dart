import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddServiceRequest {
  int? categoryId;
  String? nameAr;
  String? nameEn;
  double? price;

  AddServiceRequest(BuildContext context,
      {required this.categoryId,
      required this.nameAr,
      required this.nameEn,
      required this.price}) {
    if (nameAr == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the name in arabic',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if (nameEn == null) {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the name in english',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }

    if (price == null) {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the price',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
    }
  }

  AddServiceRequest.fromJson(Map<String, dynamic> json) {

    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    categoryId = json['category_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['category_id'] = categoryId;
    data['price'] = price;

    return data;
  }
}
