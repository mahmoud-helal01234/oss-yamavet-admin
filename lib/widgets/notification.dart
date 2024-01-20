import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/NotificationsProvider.dart';
import 'package:yama_vet_admin/core/helper/stepper.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/widgets/notification_stepper.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return Consumer<NotificationsProvider>(
        builder: (context, notificationsProvider, child) {
      return ListView.builder(
          padding: EdgeInsets.only(left: 10.w),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: notificationsProvider.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            log("type:" +
                notificationsProvider.notifications[index].type! +
                " appointment " +
                (notificationsProvider.notifications[index].appointment == null)
                    .toString());
            if (notificationsProvider.notifications[index].type == "1" &&
                notificationsProvider.notifications[index].appointment ==
                    null) {
              return SizedBox();
            } else if (notificationsProvider.notifications[index].type == "1") {
              return AppointmentNotification(notificationIndex: index);
            } else if (notificationsProvider.notifications[index].type == "2" &&
                notificationsProvider.notifications[index].reminder == null)
              return SizedBox();
            else if (notificationsProvider.notifications[index].type == "2") {
              return ReminderNotification(notificationIndex: index);
            } else {
              return SizedBox();
            }
          });
    });
  }
}

class AppointmentNotification extends StatefulWidget {
  AppointmentNotification({super.key, required this.notificationIndex});

  int notificationIndex;

  @override
  State<AppointmentNotification> createState() =>
      _AppointmentNotificationState();
}

class _AppointmentNotificationState extends State<AppointmentNotification> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return Consumer<NotificationsProvider>(
        builder: (context, notificationsProvider, child) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: mediaHeight > 900 ? 10 : 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${"Appointment".tr()} " +  "#" + notificationsProvider.notifications[widget.notificationIndex].appointment!.id.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'futuraMd',
                      fontWeight: FontWeight.bold),
                ),

                // Text(
                //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${notificationsProvider.notifications[widget.notificationIndex].appointment!.type == "ordinary" ? "ordinary".tr() : "emergency".tr()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'futuraMd',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    notificationsProvider
                        .notifications[widget.notificationIndex]
                        .appointment!
                        .status ??
                        "",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'futuraMd',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Text(
                //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  notificationsProvider.notifications[widget.notificationIndex].client!.name ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'futuraMd',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    notificationsProvider.notifications[widget.notificationIndex].client!.phone ??
                        "",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'futuraMd',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Text(
                //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // )
              ],
            ),


            const Divider(
              color: Colors.white60,
              thickness: 1,
              endIndent: 10,
              indent: 10,
            ),
          ],
        ),
      );
    });
  }
}

class ReminderNotification extends StatefulWidget {
  ReminderNotification({super.key, required this.notificationIndex});

  int notificationIndex;

  @override
  State<ReminderNotification> createState() => _ReminderNotificationState();
}

class _ReminderNotificationState extends State<ReminderNotification> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400

    return Consumer<NotificationsProvider>(
        builder: (context, notificationsProvider, child) {
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: mediaHeight > 900 ? 10 : 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Reminder".tr() + " #" + notificationsProvider.notifications[widget.notificationIndex].reminder!.id.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'futuraMd',
                          fontWeight: FontWeight.bold),
                    )
                    // Text(
                    //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                    //   style: TextStyle(
                    //       color: Colors.white, fontWeight: FontWeight.bold),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      notificationsProvider.notifications[widget.notificationIndex].client!.name!,

                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'futuraMd',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(notificationsProvider.notifications[widget.notificationIndex].client!.phone!,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'futuraMd',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Text(
                    //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                    //   style: TextStyle(
                    //       color: Colors.white, fontWeight: FontWeight.bold),
                    // )
                  ],
                )
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(

                      notificationsProvider
                          .notifications[widget.notificationIndex]
                          .reminder!.description
                          ??
                          "",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'futuraMd',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        notificationsProvider
                            .notifications[widget.notificationIndex]
                            .reminder!.appointmentDate
                            ??
                            "",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'futuraMd',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Text(
                    //   "${notificationsProvider.notifications[widget.notificationIndex].appointment!.price ?? ""} \$",
                    //   style: TextStyle(
                    //       color: Colors.white, fontWeight: FontWeight.bold),
                    // )
                  ],
                ),


                const Divider(
                  color: Colors.white60,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
              ],
            ),
          );
        });
  }
}
