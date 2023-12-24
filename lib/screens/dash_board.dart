import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/dash_card.dart';
import 'package:yama_vet_admin/widgets/notification.dart';

import '../controllers/ConfigurationsProvider.dart';
import '../controllers/SettingsProvider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ConfigurationsProvider>(context, listen: false).get(context);
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    bottomLeft: Radius.circular(40.w))),
            width: mediaWidth > 650 ? 150.w : 200.w,
            child: MenuScreen()),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
                height: mediaWidth > 650
                    ? .05 * mediaWidth
                    : .02 * MediaQuery.sizeOf(context).height,
              ),
              Row(children: [
                SizedBox(
                  width: .05 * MediaQuery.sizeOf(context).width,
                ),
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      "assets/images/menuIcon.png",
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                      onTap: () {
                        _dialogBuilder(context);
                      },
                      child: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/Notification.png"),
                        ),
                        Positioned(
                          // draw a red marble
                          top: 0.0,
                          left: 0.0,

                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        )
                      ])),
                ),
              ]),
              Center(
                child: Text(
                  "dashboard".tr(),
                  style: TextStyle(
                      fontFamily: 'futurBold',
                      color: primary,
                      fontSize: mediaWidth > 650 ? 20.sp : 20.sp),
                ),
              ),
              SizedBox(
                height: mediaWidth > 650 ? 50.h : 10.h,
              ),
              (Provider.of<SettingsProvider>(context, listen: true).role !=
                      "vet")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //* offers screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, offers);
                          },
                          child: DashCard(
                            img: "assets/images/offers.png",
                            text: 'offers'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                        //* categories screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, categories);
                          },
                          child: DashCard(
                            img: "assets/images/services.png",
                            text: 'categories'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //* oppointments screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, appointments);
                          },
                          child: DashCard(
                            img: "assets/images/appointments.png",
                            text: 'appointments'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                        //*reminder screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, reminder);
                          },
                          child: DashCard(
                            img: "assets/images/reminder.png",
                            text: 'Reminder'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        )
                      ],
                    ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 10.h,
              ),
              (Provider.of<SettingsProvider>(context, listen: true).role !=
                      "vet")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //*clients screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, clients);
                          },
                          child: DashCard(
                            img: "assets/images/clients.png",
                            text: 'clients'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                        //* vet screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, vetProfiles);
                          },
                          child: DashCard(
                            img: "assets/images/vets.png",
                            text: 'Vet'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //* offers screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, offers);
                          },
                          child: DashCard(
                            img: "assets/images/offers.png",
                            text: 'offers'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                        //* categories screen
                      ],
                    ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 10.h,
              ),
              (Provider.of<SettingsProvider>(context, listen: true).role !=
                      "vet")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //* oppointments screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, appointments);
                          },
                          child: DashCard(
                            img: "assets/images/appointments.png",
                            text: 'appointments'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        ),
                        //*reminder screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, reminder);
                          },
                          child: DashCard(
                            img: "assets/images/reminder.png",
                            text: 'reminder'.tr(),
                            size: mediaWidth > 650 ? 20.sp : 22.sp,
                          ),
                        )
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Image.asset("assets/images/dash.png"),
              )
            ]))));
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  double mediaHeight = MediaQuery.sizeOf(context).height; //!900

  return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                margin: const EdgeInsets.only(
                    top: 60, bottom: 50, left: 20, right: 50),
                height: mediaHeight > 900
                    ? .5 * mediaHeight
                    : .65 * MediaQuery.sizeOf(context).height,
                width: MediaQuery.of(context).size.width,
                color: primary,
                child: Scaffold(
                    backgroundColor: primary, body: NotificationBody()),
              ),
            )
          ],
        );
      });
}
