import 'package:date_field/date_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/controllers/RemindersProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/requests/AddReminderRequest.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/client_row_search.dart';
import 'package:yama_vet_admin/widgets/reminder_body.dart';

import '../widgets/custom_add_buttom.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<RemindersProvider>(context, listen: false).get(context);
    Provider.of<ClientsProvider>(context, listen: false).get(context);
  }

  Future<void> getReminders() async {}

  @override
  Widget build(BuildContext context) {
    context.loaderOverlay.hide();
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
                height: 10.h,
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
              Container(
                  height: 0.8.sh,
                  child: Consumer<RemindersProvider>(
                      builder: (context, remindersProvider, child) {
                    return ListView.builder(
                        padding: EdgeInsets.only(left: 10.w),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: remindersProvider.reminders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ReminderBody(
                            reminderIndex: index,
                            width: MediaQuery.sizeOf(context).width > 650
                                ? .7 * mediaWidth
                                : .9 * MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).width > 650
                                ? 200.h
                                : 150.h,
                            textAlign: TextAlign.center,
                          );
                        });
                  })),
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
                    padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
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
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (
                                BuildContext context,
                              ) {
                                return StatefulBuilder(builder: (BuildContext
                                        context,
                                    void Function(void Function()) setState) {
                                  return Dialog(
                                      alignment: Alignment.bottomRight,
                                      backgroundColor: const Color(0xffefefef),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Container(
                                          height: 350.h,
                                          width: mediaWidth,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffefefef),
                                              border:
                                                  Border.all(color: primary)),
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
                                                //           color:
                                                //               primary)),
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
                                                //                       Icons.search,
                                                //                       color:
                                                //                           primary,
                                                //                     )),
                                                //             hintText:
                                                //                 'Search Client by Name ',
                                                //             hintStyle: TextStyle(
                                                //                 color: Colors.grey[
                                                //                     500],
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w500,
                                                //                 fontSize:
                                                //                     15)),
                                                //     onChanged:
                                                //         (String query) {},
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: mediaWidth > 650
                                                      ? 20.h
                                                      : 10.h,
                                                ),
                                                Container(
                                                    height: 0.8.sh,
                                                    child: Consumer<
                                                            ClientsProvider>(
                                                        builder: (context,
                                                            clientsProvider,
                                                            child) {
                                                      return ListView.builder(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.w),
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              clientsProvider
                                                                  .clients
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ClientSearch(
                                                                clientIndex:
                                                                    index);
                                                          });
                                                    })),
                                              ]))));
                                });
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Image.asset(
                                      "assets/images/female_one.png"),
                                ),
                              ),
                            ),
                            Provider.of<RemindersProvider>(context,
                                            listen: true)
                                        .selectedClientIndex ==
                                    null
                                ? Container(
                                    height: 50.h,
                                    width: 0.5.sw,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Container(
                                        child: Text(
                                      "Select Client".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.sizeOf(context).width >
                                                      650
                                                  ? 22.sp
                                                  : 17.sp,
                                          color: Colors.grey),
                                    )),
                                  )
                                : Container(
                                    height: 50.h,
                                    width: 0.5.sw,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Container(
                                        child: Text(
                                      Provider.of<ClientsProvider>(context,
                                              listen: false)
                                          .clients[
                                              Provider.of<RemindersProvider>(
                                                      context,
                                                      listen: true)
                                                  .selectedClientIndex!]
                                          .name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.sizeOf(context).width >
                                                      650
                                                  ? 22.sp
                                                  : 17.sp,
                                          color: Colors.black),
                                    )),
                                  ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            )
                          ],
                        ),
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
                            Provider.of<RemindersProvider>(context,
                                                listen: true)
                                            .addReminderRequest !=
                                        null &&
                                    Provider.of<RemindersProvider>(context,
                                                listen: true)
                                            .addReminderRequest!
                                            .appointmentDate !=
                                        null
                                ? Provider.of<RemindersProvider>(context,
                                        listen: true)
                                    .addReminderRequest!
                                    .appointmentDate!
                                : "DD/MM/YY",
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
                            child: DateTimeField(
                              mode: DateTimeFieldPickerMode.date,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(
                                  Icons.event_note,
                                  color: Colors.white,
                                ),
                              ),
                              // selectedDate: appointmentsProvider.from,
                              dateTextStyle: TextStyle(fontSize: 10.sp),
                              onDateSelected: (DateTime value) {
                                Provider.of<RemindersProvider>(context,
                                        listen: false)
                                    .changeAddReminderRequest(
                                        appointmentDate:
                                            DateFormat('yyyy-MM-dd')
                                                .format(value));
                              },
                              selectedDate: DateTime.tryParse(
                                  Provider.of<RemindersProvider>(context,
                                                      listen: true)
                                                  .addReminderRequest !=
                                              null &&
                                          Provider.of<RemindersProvider>(
                                                      context,
                                                      listen: true)
                                                  .addReminderRequest!
                                                  .appointmentDate !=
                                              null
                                      ? Provider.of<RemindersProvider>(context,
                                              listen: true)
                                          .addReminderRequest!
                                          .appointmentDate!
                                      : DateFormat('EEEE')
                                          .format(DateTime.now())),
                            ),
                            // Icon(
                            //   Icons.calendar_month_outlined,
                            //   color: Colors.white,
                            // ),
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
                                onChanged: (value) {
                                  Provider.of<RemindersProvider>(context,
                                          listen: false)
                                      .changeAddReminderRequest(
                                          description: value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomAddButton(
                        onPress: () async {
                          Provider.of<RemindersProvider>(context, listen: false)
                              .changeAddReminderRequest(
                                  clientId: Provider.of<ClientsProvider>(
                                          context,
                                          listen: false)
                                      .clients[Provider.of<RemindersProvider>(
                                              context,
                                              listen: false)
                                          .selectedClientIndex!]
                                      .id);

                          Provider.of<RemindersProvider>(context, listen: false)
                              .create(
                                  context,
                                  Provider.of<RemindersProvider>(context,
                                          listen: false)
                                      .addReminderRequest!);
                        },
                        minwidth: .7 * mediaWidth,
                      ),
                    ]),
                  ),
                ),
              ),
            );
          },
        );
      });
}
