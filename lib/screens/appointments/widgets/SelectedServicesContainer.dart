import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/responses/CategoriesResponse.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../../../controllers/AppointmentsProvider.dart';
import '../../../controllers/CategoriesProvider.dart';

class SelectedServicesContainer extends StatefulWidget {
  SelectedServicesContainer({super.key, required this.appointmentIndex});

  int appointmentIndex;

  @override
  State<SelectedServicesContainer> createState() =>
      _SelectedServicesContainerState();
}

class _SelectedServicesContainerState extends State<SelectedServicesContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.95.sw,
        height: .1.sh,
        padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: primary)),
        child: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
            return Column(
              children: [
                Container(
                    height: 70.h,
                    child: ListView.builder(
                      itemCount: appointmentsProvider
                          .updateAppointmentRequest!.petIds!.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Column(
                          children: [
                            Text(appointmentsProvider.updateAppointmentRequest!
                                .petIds![index].pet!.name!),
                            Column(
                              children: appointmentsProvider.updateAppointmentRequest!
                                  .petIds![index].services!.values!.map((service) => Container(

                                child: Row(
                                  children: [
                                    Text("- "),
                                    Container(
                                      width: 0.6.sw,
                                      child: Text(
                                        context.locale.toString() == "ar"
                                            ? "${service!.nameAr} \t"
                                            : "${service!.nameEn} \t",
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                        "${service!.price}"),
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.sp),
                                      child: const Text(
                                        "\$",
                                        style:
                                        TextStyle(color: Colors.green),
                                      ),
                                    )
                                  ],
                                ),
                              )).toList()
                            ),
                          ],
                        );
                      },
                    )),

              ],
            );
          },
        ));
  }
}