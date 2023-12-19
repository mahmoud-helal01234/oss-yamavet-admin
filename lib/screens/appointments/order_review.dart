import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/helper/stepper.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/screens/appointments/select_services.dart';
import 'package:yama_vet_admin/screens/menu.dart';

import 'package:yama_vet_admin/widgets/order_over_view.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/LocationAndCashStatusRow.dart';

import '../../controllers/AppointmentsProvider.dart';
import '../../controllers/SettingsProvider.dart';

// ignore: must_be_immutable
class OrderReview extends StatefulWidget {
  OrderReview({
    super.key,
    required this.appointmentIndex,
    // required this.servicewidget,
    required this.onTap,
    // required this.text,
  });

  bool status = false;
  final int appointmentIndex;

  // final String text;

  // final Widget widgetrow;
  final void Function()? onTap;
  // final Widget servicewidget;

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // String text = 'Notcollected';
  bool ontap = false;
  bool choosen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    bottomLeft: Radius.circular(40.sp))),
          width: mediaWidth > 650 ? 150.w : 200.w,
            child: MenuScreen()),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
                height: .02 * MediaQuery.sizeOf(context).height,
              ),
              Row(children: [
                SizedBox(
                  width: .05 * MediaQuery.sizeOf(context).width,
                ),
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset("assets/images/menuIcon.png")),
              ]),
              SizedBox(
                height: mediaWidth > 650 ? 10.h : 5.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: mediaWidth > 650 ? 30.w : 0,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20.sp,
                        weight: 100.5,
                        color: Colors.black,
                      )),
                  Consumer<AppointmentsProvider>(
                      builder: (context, appointmentsProvider, child) {
                    return Text(
                      "Appointments Overview #[${appointmentsProvider.appointments[widget.appointmentIndex].appointmentNumber}]",
                      style: TextStyle(
                          fontFamily: 'futurBold',
                          color: primary,
                          fontSize: 17.sp),
                    );
                  }),
                  SizedBox(
                    height: mediaHeight > 900 ? 20.h : 0,
                  )
                ],
              ),
              (Provider.of<SettingsProvider>(context, listen: true).role !=
                      'vet')
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          // elevation: 5,
                          minWidth: mediaWidth > 650 ? 400.w : 150.w,
                          height: mediaWidth > 650 ? 40.h : 30.h,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.sp)),
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<AppointmentsProvider>(context,
                                    listen: false)
                                .delete(context, widget.appointmentIndex);
                          },
                          child: Text("Delete".tr(),
                              style: TextStyle(
                                  fontFamily: 'futur',
                                  color: Colors.white,
                                  fontSize: mediaWidth > 650 ? 20.sp : 15.sp)),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Provider.of<AppointmentsProvider>(context, listen: true)
                                    .appointments[widget.appointmentIndex]
                                    .type ==
                                "emergancy"
                            ? Container()
                            : MaterialButton(
                                // elevation: 5,
                                minWidth: mediaWidth > 650 ? 400.w : 150.w,
                                height: mediaWidth > 650 ? 40.h : 30.h,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp)),
                                color: primary,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectServices(
                                              appointmentIndex:
                                                  widget.appointmentIndex,
                                            )),
                                  );
                                },
                                child: Text("Update".tr(),
                                    style: TextStyle(
                                        fontFamily: 'futur',
                                        color: Colors.white,
                                        fontSize:
                                            mediaWidth > 650 ? 20.sp : 15.sp)),
                              ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 5.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: mediaWidth > 400
                        ? .05 * MediaQuery.sizeOf(context).width
                        : .02 * mediaWidth,
                  ),
                  Icon(
                    Icons.calendar_month_outlined,
                    weight: 30.sp,
                  ),
                  Consumer<AppointmentsProvider>(
                      builder: (context, appointmentsProvider, child) {
                    return Text(
                      appointmentsProvider
                          .appointments[widget.appointmentIndex].day!,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: mediaWidth > 650 ? 20.sp : 17.sp),
                    );
                  }),
                  SizedBox(
                    width: mediaWidth > 650
                        ? .6 * mediaWidth
                        : .2 * MediaQuery.sizeOf(context).width,
                  ),
                  Row(
                    children: [
                      Text(
                        "totalprice".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mediaWidth > 650 ? 20.sp : 17.sp),
                      ),
                      Consumer<AppointmentsProvider>(
                          builder: (context, appointmentsProvider, child) {
                        return Text(
                          "${appointmentsProvider.appointments[widget.appointmentIndex].price}\$",
                          style: TextStyle(
                              color: primary, fontWeight: FontWeight.bold),
                        );
                      }),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: mediaHeight > 900 ? 20.h : 10.h,
              ),
              LocationAndCashStatusRow(
                  appointmentIndex: widget.appointmentIndex),
              SizedBox(
                height: mediaHeight > 900 ? 30.h : 10.h,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: .05 * MediaQuery.sizeOf(context).width,
                  ),
                  Image.asset("assets/images/dr.png"),
                  SizedBox(
                    width: .05 * MediaQuery.sizeOf(context).width,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/icon_doctor.png"),
                          SizedBox(
                            width: 5.w,
                          ),
                          Consumer<AppointmentsProvider>(
                              builder: (context, appointmentsProvider, child) {
                            return appointmentsProvider
                                        .appointments[widget.appointmentIndex]
                                        .doctor !=
                                    null
                                ? Text(appointmentsProvider
                                    .appointments[widget.appointmentIndex]
                                    .doctor!
                                    .name!)
                                : Container();
                          }),
                          SizedBox(
                            width: mediaWidth > 650
                                ? .53 * mediaWidth
                                : .1 * MediaQuery.sizeOf(context).width,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                           Text(
                            "rating".tr(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                          ),
                        ],
                      ),
                      Provider.of<AppointmentsProvider>(context, listen: true)
                                      .appointments[widget.appointmentIndex]
                                      .doctor !=
                                  null &&
                              Provider.of<AppointmentsProvider>(context,
                                          listen: true)
                                      .appointments[widget.appointmentIndex]
                                      .doctor!
                                      .totalRate !=
                                  null
                          ? Row(
                              children: [
                                Text(
                                  Provider.of<AppointmentsProvider>(context,
                                          listen: true)
                                      .appointments[widget.appointmentIndex]
                                      .doctor!
                                      .totalRate!
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                                Text(
                                  "/5",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         ontap = !ontap;
                  //       });
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return Dialog(
                  //               alignment: Alignment.centerRight,
                  //               backgroundColor: const Color(0xffefefef),
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(
                  //                       10)), //this right here
                  //               child: Container(
                  //                 height: 350,
                  //                 width: mediaWidth,
                  //                 color: const Color(0xffefefef),
                  //                 child: SingleChildScrollView(
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                         width: mediaWidth > 650 ? 820 : 600,
                  //                         height: 40,
                  //                         decoration: BoxDecoration(
                  //                             color: const Color(0xffefefef),
                  //                             border:
                  //                                 Border.all(color: primary)),
                  //                         child: TextField(
                  //                           decoration: InputDecoration(
                  //                               border: InputBorder.none,
                  //                               prefixIcon: RotatedBox(
                  //                                   quarterTurns: 1,
                  //                                   child: Icon(
                  //                                     Icons.search,
                  //                                     color: primary,
                  //                                   )),
                  //                               hintText:
                  //                                   'Search Doctors by Name ',
                  //                               hintStyle: TextStyle(
                  //                                   color: Colors.grey[500],
                  //                                   fontWeight: FontWeight.w500,
                  //                                   fontSize: 15)),
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         height: mediaWidth > 650 ? 10 : 5,
                  //                       ),
                  //                       DoctorsChooseMenu(
                  //                         choosen: choosen,
                  //                       ),
                  //                       DoctorsChooseMenu(
                  //                         choosen: choosen,
                  //                       ),
                  //                       DoctorsChooseMenu(
                  //                         choosen: choosen,
                  //                       ),
                  //                       DoctorsChooseMenu(
                  //                         choosen: choosen,
                  //                       ),
                  //                       DoctorsChooseMenu(
                  //                         choosen: choosen,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           });
                  //     },
                  //     child: Icon(!ontap
                  //         ? Icons.arrow_forward_ios
                  //         : Icons.keyboard_arrow_down_outlined)),
                ],
              ),
              SizedBox(
                height: mediaHeight > 900 ? 40.h : 20.h,
              ),
              Consumer<AppointmentsProvider>(
                  builder: (context, appointmentsProvider, child) {
                return StepperScreen(
                  lineColor: primary,
                  stepperColor: primary,
                  textColor: Colors.black,
                  status: appointmentsProvider
                      .appointments[widget.appointmentIndex].status!,
                );
              }),
              SizedBox(
                height: mediaHeight > 900 ? 40.h : 20.h,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                    width: 500.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: Column(
                      children: [
                        Consumer<AppointmentsProvider>(
                            builder: (context, appointmentsProvider, child) {
                          return Container(
                            height: 80.h,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: appointmentsProvider
                                    .appointments[widget.appointmentIndex]
                                    .appointmentDetails!
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 100.w,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.sp,
                                                  backgroundImage: NetworkImage(
                                                    "https://yama-vet.com/${appointmentsProvider.appointments[widget.appointmentIndex].appointmentDetails![index].pet!.imgPath}",
                                                  ),
                                                ),
                                                Text(
                                                    "${appointmentsProvider.appointments[widget.appointmentIndex].appointmentDetails![index].pet!.name}")
                                              ],
                                            ),
                                          )
                                        ]),
                                  );
                                }),
                          );
                        })
                      ],
                    )),
              ),
              Center(
                  child: Text(
                "services".tr(),
                style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp),
              )),
              OrderOverViewContainer(
                appointmentIndex: widget.appointmentIndex,
              ),
            ]))));
  }
}

Future<void> dialogBuilderSearch(BuildContext context) {
  double mediaHeight = MediaQuery.sizeOf(context).height; //!900
  double mediaWidth = MediaQuery.sizeOf(context).width; //!400
  return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 600.w,
          height: 400.h,
          margin: EdgeInsets.only(top: .1 * mediaHeight),
          child: Dialog(
            child: Container(
                width: mediaWidth,
                height: .37 * mediaHeight,
                margin: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  border: Border.all(color: primary, width: 1.w),
                  color: const Color(0xffefefef),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 500.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: primary),
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: const TextField(
                        decoration:
                            InputDecoration(prefixIcon: Icon(Icons.search)),
                      ),
                    )
                  ],
                )),
          ),
        );
      });
}
