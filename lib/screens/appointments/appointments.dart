import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/appoint_model.dart';
import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/data/models/doctor_models.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/AppointmentStatusFilter.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/appointment_container.dart';
import 'package:yama_vet_admin/widgets/clients_show_menu.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/doctors_menu.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/filter_row.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? text;
  bool status = false;
  AppointModel? appointModel;
  ClientsModel? clientsModel;
  List<DoctorModel> doctors = [];
  List<ClientsModel> clients = [];

  @override
  void initState() {
    super.initState();
  }

  void openGoogleMaps(double lat, double long) async {
    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isNotEmpty) {
      await MapLauncher.showMarker(
        coords: Coords(lat, long),
        title: 'Google Maps',
        description: 'Your location',
        mapType: MapType.google,
      );
    } else {
      // Handle the case where no map apps are installed
      print('No maps apps are installed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    bottomLeft: Radius.circular(40.sp))),
            width: 200.w,
            child: MenuScreen()),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                width: mediaHeight > 900 ? .35 * mediaWidth : .15 * mediaWidth,
              ),
              Text(
                "Appointments",
                style: TextStyle(
                    fontFamily: 'futurBold', color: primary, fontSize: 20.sp),
              ),
              SizedBox(
                height: mediaHeight > 900 ? 20.h : 0,
              ),
            ],
          ),
          SizedBox(
            height: mediaWidth > 650 ? 20.h : 10.h,
          ),
          FilterRow(),

          const AppointmentStatusFilter(),
          SizedBox(
            height: mediaWidth > 650 ? 19.h : 9.h,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Center(
          //   child: Container(
          //     width: .95 * mediaWidth,
          //     height: 40,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         border: Border.all(color: primary, width: 1.5)),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(
          //             text ?? "Doctors",
          //             style: const TextStyle(
          //                 fontFamily: 'futur',
          //                 fontSize: 17,
          //                 color: Colors.black),
          //           ),
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.keyboard_arrow_down_sharp),
          //           onPressed: () {
          //             doctorMenu(context);
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Center(
          //   child: Container(
          //     width: .95 * mediaWidth,
          //     height: 40,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         border: Border.all(color: primary, width: 1.5)),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         const Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Text(
          //             "Clients",
          //             style: TextStyle(
          //                 fontFamily: 'futur',
          //                 fontSize: 17,
          //                 color: Colors.black),
          //           ),
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.keyboard_arrow_down_sharp),
          //           onPressed: () {
          //             clietsMenu(context);
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // StatusRow(status: status, cash: 'cash'),
          // SizedBox(
          //   height: 10,
          // ),
          AppointmentContainer(
            textEmergancy: 'Max',
            textColor: Colors.white,
            textalign: TextAlign.start,
            paddingtext: EdgeInsets.only(left: 5.w),
            init: true,
            pic: 1,
          ),
        ])));
  }

  void doctorMenu(
    BuildContext context,
  ) {
    // bool choosen = false;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    showMenu(
      // shadowColor: primary,
      constraints: BoxConstraints(
          minWidth: mediaWidth > 650 ? 800.w : 270.w,
          maxWidth: mediaWidth > 650 ? mediaWidth : 370.w),
      color: const Color(0xffefefef),
      // elevation: 5,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
          side: BorderSide(color: primary)),
      position: RelativeRect.fromLTRB(mediaWidth > 650 ? 2.w : 1.w,
          mediaWidth > 400 ? 340.h : 340.h, 1.w, 1.w),
      items: [
        PopupMenuItem(
            onTap: () {
              setState(() {
                text = ' Dr.Benjamin Carter';
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return DoctorsChooseMenu();
              },
            )),
      ],
    );
  }

  void setDoctors() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey('doctoresEncoded')) {
      String decode = sharedPreferences.getString('doctoresEncoded')!;
      doctors = jsonDecode(decode);
    }
    print("***********$doctors");
  }

  void setClients(List<ClientsModel> clientsList) {
    clients = clientsList;
  }

  void clietsMenu(BuildContext context) {
    bool choosen = false;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    showMenu(
      // shadowColor: primary,
      constraints: BoxConstraints(
          minWidth: mediaWidth > 650 ? 800.w : 270.w,
          maxWidth: mediaWidth > 650 ? mediaWidth : 370.w),
      color: const Color(0xffefefef),
      // elevation: 5,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
          side: BorderSide(color: primary)),
      position: RelativeRect.fromLTRB(mediaWidth > 650 ? 2.w : 1.w,
          mediaWidth > 400 ? 200.h : 500.h, 1.w, 1.h),
      items: [
        PopupMenuItem(
            onTap: () {
              setState(() {
                // text = ' Dr.Benjamin Carter';
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return ClientShowMenu(
                  choosen: choosen,
                );
              },
            )),
      ],
    );
  }
}
