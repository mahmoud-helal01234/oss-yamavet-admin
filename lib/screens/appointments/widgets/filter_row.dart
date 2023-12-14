import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/doctor_models.dart';

// ignore: must_be_immutable
class FilterRow extends StatelessWidget {
  FilterRow({super.key});
  List<DoctorModel> doctors = [];
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: mediaWidth > 650
          ? MainAxisAlignment.spaceEvenly
          : MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            SizedBox(
              width: mediaWidth > 650 ? .06 * mediaWidth : 0,
            ),
            MaterialButton(
              minWidth: MediaQuery.sizeOf(context).width > 650 ? 70 : 50,
              color: primary,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                Provider.of<AppointmentsProvider>(context, listen: false)
                    .getAppointments(context);
                // Provider.of<AppointmentsProvider>(context,listen: false).filterAppointments();
              },
              child: Text(
                "Applyfilter".tr(),
                style: TextStyle(
                    fontSize: 15, color: Colors.white, fontFamily: 'futur'),
              ),
            )
          ],
        ),
        Text(Provider.of<AppointmentsProvider>(context, listen: true)
            .totalPrice
            .toString()),
        SizedBox(
          width: mediaWidth > 650 ? .15 * mediaWidth : 0,
        ),
        // Row(
        //   children: [
        //     Text(
        //       "Total :",
        //       style: TextStyle(
        //           fontSize: 20, color: primary, fontWeight: FontWeight.w600),
        //     ),
        //     const Text(
        //       "8,000",
        //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        //     ),
        //     const Text(
        //       " \$",
        //       style:
        //           TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        //     )
        //   ],
        // ),

        SizedBox(
          width: mediaWidth > 650 ? .1 * mediaWidth : 0,
        ),
        MaterialButton(
          minWidth: MediaQuery.sizeOf(context).width > 650 ? 70 : 50,
          color: primary,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            Provider.of<AppointmentsProvider>(context, listen: false)
                .clearFilters(context);
          },
          child: Text(
            "Clearfilter".tr(),
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontFamily: 'futur'),
          ),
        )
      ],
    );
  }

  void setDoctors() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey('doctoresEncoded')) {
      String? decoded = sharedPreferences.getString('doctoresEncoded');
      Map<String, dynamic> decoded1 = json.decode(decoded.toString());
      Map<String, String> decodedDoctors =
          decoded1.map((key, value) => MapEntry(key, value.toString()));
      print("------------");
      print("***********$decodedDoctors");
    }
  }
}
