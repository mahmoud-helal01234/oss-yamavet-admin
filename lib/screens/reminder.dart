import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/client_row.dart';
import 'package:yama_vet_admin/widgets/client_row_search.dart';
import 'package:yama_vet_admin/widgets/reminder_body.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).height;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    bottomLeft: Radius.circular(40.sp))),
            width: mediaHeight > 900 ? 150.w : 200.w,
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
                height: 20.h,
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
                  SizedBox(
                    width: mediaHeight > 900
                        ? .08 * mediaWidth.w
                        : .09 * mediaWidth,
                  ),
                  Text(
                    "reminder".tr(),
                    style: TextStyle(
                        fontFamily: 'futurBold',
                        color: primary,
                        fontSize: mediaHeight > 900 ? 17.sp : 20.sp),
                  ),
                  SizedBox(
                    height: mediaHeight > 900 ? 20.sp : 0,
                  ),
                ],
              ),
              SizedBox(
                height: mediaHeight > 900 ? 10.h : 0,
              ),
              Center(
                child: MaterialButton(
                  color: primary,
                  minWidth: MediaQuery.sizeOf(context).width > 650
                      ? .9 * MediaQuery.sizeOf(context).width
                      : .9 * MediaQuery.sizeOf(context).width,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp)),
                  onPressed: () {
                    dialogBuilder(context, false);
                  },
                  child: Text(
                    "Send Reminder".tr(),
                    style: TextStyle(
                        fontSize: mediaHeight > 900 ? 15.sp : 20.sp,
                        color: Colors.white,
                        fontFamily: 'futur'),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ReminderBody(
                doctorName: 'Rachel Green',
                sendDate: 'sent : 17/5/2023',
                text: """Hi Rachel Green,
            We hope you and your furry friend are doing well. A friendly reminder about your pet's upcoming health check-in on [20/7/2023] at [1:23 pm]. Ensure your pet is comfortable, and feel free to jot down any specific concerns or questions.""",
                width: MediaQuery.sizeOf(context).width > 650
                    ? .7 * mediaWidth
                    : .9 * MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width > 650 ? 200.h : 150.h,
                textAlign: TextAlign.center,
              ),
              ReminderBody(
                doctorName: 'Monica Geller',
                sendDate: 'sent : 15/5/2023',
                text: "Pet Health Check-in Tomorrow!",
                width: mediaWidth > 650 ? .7 * mediaWidth : .45 * mediaWidth,
                height: mediaWidth > 650 ? 50.h : 40.h,
                textAlign: TextAlign.start,
              ),
              ReminderBody(
                doctorName: 'Rachel Green',
                sendDate: 'sent : 17/5/2023',
                text: """Hi Rachel Green,
            We hope you and your furry friend are doing well. A friendly reminder about your pet's upcoming health check-in on [20/7/2023] at [1:23 pm]. Ensure your pet is comfortable, and feel free to jot down any specific concerns or questions.""",
                width: mediaWidth > 650 ? .7 * mediaWidth : .45 * mediaWidth,
                height: mediaWidth > 650 ? 200.h : 180.h,
                textAlign: TextAlign.center,
              ),
            ]))));
  }
}

Future<void> dialogBuilder(BuildContext context, bool selected) {
  bool ontap = false;

  double mediaHeight = MediaQuery.sizeOf(context).height; //!900
  double mediaWidth = MediaQuery.sizeOf(context).width; //!400
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return GestureDetector(
              child: Card(
                margin: EdgeInsets.only(
                    top: ontap ? 20.h : .45 * mediaHeight,
                    bottom: ontap ? 150.h : 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp))),
                elevation: 30,
                // color: Colors.white,
                child: GestureDetector(
                  child: Container(
                    width: mediaWidth,
                    height: .5 * mediaHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              spreadRadius: 1,
                              blurRadius: 20)
                        ]),
                    child: Column(children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            width: 50.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child:
                                    Image.asset("assets/images/female_one.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Select Client \n\n",
                            style: TextStyle(
                                fontSize: MediaQuery.sizeOf(context).width > 650
                                    ? 10.sp
                                    : 15,
                                color: Colors.grey),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (
                                      BuildContext context,
                                    ) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Dialog(
                                            alignment: Alignment.bottomRight,
                                            backgroundColor:
                                                const Color(0xffefefef),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10
                                                        .sp)), //this right here
                                            child: Container(
                                              height: 350.h,
                                              width: mediaWidth,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffefefef),
                                                  border: Border.all(
                                                      color: primary)),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Container(
                                                    //   width: mediaWidth > 650
                                                    //       ? 900
                                                    //       : 600,
                                                    //   height: 40,
                                                    //   decoration: BoxDecoration(
                                                    //       color: const Color(
                                                    //           0xffefefef),
                                                    //       border: Border.all(
                                                    //           color: primary)),
                                                    //   child: TextField(
                                                    //     decoration:
                                                    //         InputDecoration(
                                                    //             border:
                                                    //                 InputBorder
                                                    //                     .none,
                                                    //             prefixIcon:
                                                    //                 RotatedBox(
                                                    //                     quarterTurns:
                                                    //                         1,
                                                    //                     child:
                                                    //                         Icon(
                                                    //                       Icons
                                                    //                           .search,
                                                    //                       color:
                                                    //                           primary,
                                                    //                     )),
                                                    //             hintText:
                                                    //                 'Search Client by Name ',
                                                    //             hintStyle: TextStyle(
                                                    //                 color: Colors
                                                    //                         .grey[
                                                    //                     500],
                                                    //                 fontWeight:
                                                    //                     FontWeight
                                                    //                         .w500,
                                                    //                 fontSize:
                                                    //                     15)),
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: mediaWidth > 650
                                                          ? 20.h
                                                          : 10.h,
                                                    ),
                                                    //*
                                                    ClientSearch(),
                                                    Divider(
                                                      color: Colors.white,
                                                      thickness: 2,
                                                    ),
                                                    ClientSearch(),
                                                    Divider(
                                                      color: Colors.white,
                                                      thickness: 2,
                                                    ),
                                                    ClientSearch(),
                                                    Divider(
                                                      color: Colors.white,
                                                      thickness: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "DD/MM/YY",
                            style: TextStyle(
                                fontSize: MediaQuery.sizeOf(context).width > 650
                                    ? 10.sp
                                    : 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: EdgeInsets.only(
                                right: mediaWidth > 650 ? 30.w : 10.w),
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        child: Container(
                          width: .9 * mediaWidth,
                          height: 170.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: GestureDetector(
                              child: TextField(
                                onTap: () {
                                  setState(
                                    () {
                                      ontap = !ontap;
                                    },
                                  );
                                },
                                onSubmitted: (value) {
                                  setState(
                                    () {
                                      ontap = !ontap;
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Reminder message...'.tr(),
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width > 650
                                              ? 10.sp
                                              : 15,
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            );
          },
        );
      });
}
