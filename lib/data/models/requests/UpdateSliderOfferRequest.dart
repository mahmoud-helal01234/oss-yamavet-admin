import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UpdateSliderOfferRequest {

  int? id;
  String? link;
  File? img;

  UpdateSliderOfferRequest(BuildContext context,
      {
        required this.id,
        required this.link,
      required this.img,
      }) {

    if(img == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please select an image',
        autoCloseDuration: const Duration(seconds: 4),
        showConfirmBtn: false,
      );
    }
    if (link == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter the link',
        autoCloseDuration: const Duration(seconds: 4),
        showConfirmBtn: false,
      );
    }

  }

  Map<String, String> toJson() {

    final Map<String, String> data = <String, String>{};

    data['id'] = id!.toString();
    data['link'] = link!;
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
