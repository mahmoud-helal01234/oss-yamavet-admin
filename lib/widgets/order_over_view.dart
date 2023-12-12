import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../controllers/AppointmentsProvider.dart';

class OrderOverViewContainer extends StatefulWidget {
  OrderOverViewContainer({super.key,required this.appointmentIndex});

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
    print("index:"+widget.appointmentIndex.toString());
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: .9 * MediaQuery
          .sizeOf(context)
          .width,
      height: .2 * MediaQuery
          .sizeOf(context)
          .height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(color: primary)),
      child: Consumer<AppointmentsProvider>(
        builder: (context, appointmentsProvider, child) {
          return   (appointmentsProvider.appointments[widget
              .appointmentIndex].type !="emergancy")?
            Column(
        children: [
          Container(
            height : 100.h,
            child:
                   ListView.builder(
                    itemCount: appointmentsProvider.appointments[widget
                        .appointmentIndex].appointmentDetails!.length,

                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [

                          Container(
                            height: 100.h,
                            child: ListView.builder(

                              itemCount: appointmentsProvider.appointments[widget
                                  .appointmentIndex].appointmentDetails![index].services!.length!,
                              itemBuilder: (BuildContext context, int serviceIndex) {
                                return
                                  Row(
                                    children: [
                                      Padding(
                                        padding:EdgeInsets.all(5.sp),
                                        child:
                                        Text(
                                            "${appointmentsProvider.appointments[widget
                                                .appointmentIndex].appointmentDetails![index].services![serviceIndex].nameAr} \t"),
                                      ),
                                      Padding(
                                          padding:EdgeInsets.all(5.sp),
                                          child: Text(
                                              "${appointmentsProvider.appointments[widget
                                                  .appointmentIndex].appointmentDetails![index].services![serviceIndex].nameEn} \t")
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:EdgeInsets.all(5.sp),
                                        child: Text(
                                            "${appointmentsProvider.appointments[widget
                                                .appointmentIndex].appointmentDetails![index].services![serviceIndex].price}"),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(right: 5.sp),
                                        child: Text(
                                          "\$",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      )
                                    ],
                                  );
                              },
                            ),
                          ),

                        ],
                      );
                    },
                  )


          ),
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 10.w, top: 10.h),
                child: Text("Total",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: primary,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const Spacer(),
              Padding(
                padding:  EdgeInsets.only(
                    left: 20.w, top: 10.h, right: 10.w),
                child: Text(
                  "30\$",
                  style: TextStyle(
                      color: primary, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ):
         Padding(
           padding:  EdgeInsets.only(left: 10.w, right: 10.w),
           child: Text(appointmentsProvider.appointments[widget
               .appointmentIndex].content.toString()),
         );
        },
    ));
  }
}


