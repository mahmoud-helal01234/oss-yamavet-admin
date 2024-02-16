import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../controllers/AppointmentsProvider.dart';

class OrderOverViewContainer extends StatefulWidget {
  OrderOverViewContainer({super.key, required this.appointmentIndex});

  int appointmentIndex;

  @override
  State<OrderOverViewContainer> createState() => _OrderOverViewContainerState();
}

class _OrderOverViewContainerState extends State<OrderOverViewContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.95.sw,
        height: .2.sh,
        padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: primary)),
        child: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
            return (appointmentsProvider
                        .appointments[widget.appointmentIndex].type !=
                    "emergancy")
                ? Column(
              children: [
                Container(
                    height: .18.sh,
                    child: ListView.builder(
                      itemCount: appointmentsProvider
                          .appointments[widget.appointmentIndex]!.appointmentDetails!.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Column(
                          children: [
                            Text(appointmentsProvider.appointments[widget.appointmentIndex]!.appointmentDetails![index].pet!.name!),
                            Column(
                                children: appointmentsProvider.appointments[widget.appointmentIndex]!.appointmentDetails![index].services!.map((service) => Container(

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
            )
                : Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(appointmentsProvider
                        .appointments[widget.appointmentIndex].content
                        .toString()),
                  );
          },
        ));
  }
}
