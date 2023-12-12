import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/dash_card.dart';

import '../controllers/ConfigurationsProvider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String role = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ConfigurationsProvider>(context, listen: false).get(context);
    initawaits();
  }

  void initawaits() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      role = sharedPreferences.getString("role")!;
    });

    log(role);
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
            width: 200.w,
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
              ]),
              Center(
                child: Text(
                  "Admin Dashboard",
                  style: TextStyle(
                      fontFamily: 'futurBold',
                      color: primary,
                      fontSize: mediaWidth > 650 ? 25.sp : 20.sp),
                ),
              ),
              SizedBox(
                height: mediaWidth > 650 ? 50.h : 10.h,
              ),
              (role != "vet")
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
                            text: 'Offers',
                            size: mediaWidth > 650 ? 25.sp : 17.sp,
                          ),
                        ),
                        //* categories screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, categories);
                          },
                          child: DashCard(
                            img: "assets/images/services.png",
                            text: 'Categories/Services',
                            size: mediaWidth > 650 ? 25.sp : 15.sp,
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
                            text: 'appointments',
                            size: mediaWidth > 650 ? 25.sp : 17.sp,
                          ),
                        ),
                        //*reminder screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, reminder);
                          },
                          child: DashCard(
                            img: "assets/images/reminder.png",
                            text: 'Reminder',
                            size: mediaWidth > 650 ? 25.sp : 15.sp,
                          ),
                        )
                      ],
                    ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 10.h,
              ),
              (role != "vet")
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
                            text: 'Clients',
                            size: mediaWidth > 650 ? 25.sp : 17.sp,
                          ),
                        ),
                        //* vet screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, vetProfiles);
                          },
                          child: DashCard(
                            img: "assets/images/vets.png",
                            text: 'Vets',
                            size: mediaWidth > 650 ? 25.sp : 15.sp,
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
                            text: 'Offers',
                            size: mediaWidth > 650 ? 25.sp : 17.sp,
                          ),
                        ),
                        //* categories screen
                      ],
                    ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 10.h,
              ),
              (role != "vet")
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
                            text: 'appointments',
                            size: mediaWidth > 650 ? 25.sp : 17.sp,
                          ),
                        ),
                        //*reminder screen
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, reminder);
                          },
                          child: DashCard(
                            img: "assets/images/reminder.png",
                            text: 'Reminder',
                            size: mediaWidth > 650 ? 25.sp : 15.sp,
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
