import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/appoint_model.dart';
import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/AppointmentCashStatusFilter.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/AppointmentStatusFilter.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/appointment_container.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/filter_row.dart';

import '../../controllers/SettingsProvider.dart';
import '../../controllers/UsersProvider.dart';

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
            height: 10.h,
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
                width: mediaHeight > 900 ? .35 * mediaWidth : .2 * mediaWidth.w,
              ),
              Text(
                "Appointments".tr(),
                style: TextStyle(
                    fontFamily: 'futurBold', color: primary, fontSize: 20.sp),
              ),
            ],
          ),

          FilterRow(),

          const AppointmentStatusFilter(),
          SizedBox(
            height: 5.h,
          ),
          const AppointmentCashStatusFilter(),
          // SizedBox(height: 5.h,),
          Consumer<AppointmentsProvider>(
              builder: (context, appointmentsProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.h,
                  width: 180.w,
                  child: DateTimeField(
                      mode: DateTimeFieldPickerMode.date,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                      ),
                      selectedDate: appointmentsProvider.from,
                      dateTextStyle: TextStyle(fontSize: 10.sp),
                      onDateSelected: (DateTime value) {
                        Provider.of<AppointmentsProvider>(context,
                                listen: false)
                            .changeFromFilter(value);
                      }),
                ),
                Container(
                  height: 60.h,
                  width: 180.w,
                  child: DateTimeField(
                      mode: DateTimeFieldPickerMode.date,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                      ),
                      dateTextStyle: TextStyle(fontSize: 10.sp),
                      selectedDate: appointmentsProvider.to,
                      onDateSelected: (DateTime value) {
                        Provider.of<AppointmentsProvider>(context,
                                listen: false)
                            .changeToFilter(value);
                      }),
                )
              ],
            );
          }),

          // SizedBox(
          //   height: 5.h,
          // ),
          // SizedBox(
          //   height: mediaWidth > 650 ? 15.h : 5.h,
          // ),

          Provider.of<SettingsProvider>(context, listen: true).role != "admin"
              ? Container()
              : Center(
                  child: Container(
                    width: .95 * mediaWidth,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primary, width: 1.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Provider.of<AppointmentsProvider>(context,
                                        listen: true)
                                    .selectedDoctorName ??
                                "Select Dr",
                            style: const TextStyle(
                                fontFamily: 'futur',
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          onPressed: () {
                            doctorMenu(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: 10.h,
          ),
          Provider.of<SettingsProvider>(context, listen: true).role != "admin"
              ? Container()
              : Center(
                  child: Container(
                    width: .95 * mediaWidth,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primary, width: 1.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Provider.of<AppointmentsProvider>(context,
                                        listen: true)
                                    .selectedClientName ??
                                "Select Client".tr(),
                            style: const TextStyle(
                                fontFamily: 'futur',
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          onPressed: () {
                            clientsMenu(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
          SizedBox(height: 5.h),

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
          //
          //             clientsMenu(context);
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
  ) async {
    if (Provider.of<UsersProvider>(context, listen: false).users.isEmpty)
      await Provider.of<UsersProvider>(context, listen: false).get(context);
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
        items: Provider.of<UsersProvider>(context, listen: false)
            .users
            .map((user) => PopupMenuItem(
                  onTap: () {
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .changeDoctorFilter(id: user.id!, name: user.name!);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: mediaWidth > 650 ? 500 : 370,
                        height: 50,
                        // color: check[index] ? primary : Colors.transparent,
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: mediaWidth > 650
                                    ? 1
                                    : .01 * MediaQuery.sizeOf(context).width,
                              ),
                              Container(
                                width: 70,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://yama-vet.com/${user.imgPath}"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: mediaWidth > 650
                                    ? 5
                                    : .01 * MediaQuery.sizeOf(context).width,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/icon_doctor.png",
                                          color:
                                              // check[index] ? Colors.white:
                                              Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          user.name!,
                                          style: TextStyle(
                                              color:
                                                  // check[index]
                                                  //     ?
                                                  // Colors.white
                                                  Colors.black),
                                        ),
                                        SizedBox(
                                          width: mediaWidth > 400
                                              ? .15 *
                                                  MediaQuery.sizeOf(context)
                                                      .width
                                              : .05 * mediaWidth,
                                        ),
                                      ],
                                    ),
                                  ]),
                              Spacer(),
                              // Transform.scale(
                              //   scale: 1.3,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 5),
                              //     child: Checkbox(
                              //       fillColor: MaterialStateProperty.resolveWith(
                              //           (states) {
                              //         if (!states
                              //             .contains(MaterialState.selected)) {
                              //           return Colors.white;
                              //         }
                              //         return null;
                              //       }),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(1)),
                              //       side: BorderSide(
                              //         color: primary,
                              //         width: 1,
                              //       ),
                              //       activeColor:
                              //           check[index] ? Colors.white : primary,
                              //       checkColor:
                              //           check[index] ? primary : Colors.white,
                              //       value: check[index],
                              //       onChanged: (val) async {
                              //         setState(() {
                              //           if (val == true) {
                              //             doctors.add(doctorList[index]);
                              //           } else {
                              //             for (var i = 0;
                              //                 i < doctors.length;
                              //                 i++) {
                              //               if (doctors[i].id ==
                              //                   doctorList[index].id) {
                              //                 doctors.remove(doctors[i]);
                              //               }
                              //             }
                              //           }
                              //
                              //           check[index] = val!;
                              //         });
                              //         Map<String, String> doctorsMap = {};
                              //
                              //         for (int i = 0; i < doctors.length; i++) {
                              //           doctorsMap.addAll({
                              //             'doctors[${i.toString()}][id]':
                              //                 doctors[i].id.toString()
                              //           });
                              //         }
                              //         String encode = json.encode(doctorsMap);
                              //         SharedPreferences sharedPreferences =
                              //             await SharedPreferences.getInstance();
                              //         sharedPreferences.setString(
                              //             'doctoresEncoded', encode);
                              //         print(encode);
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ]),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1.5,
                      ),
                    ],
                  ),
                ))
            .toList()
        // [
        //   PopupMenuItem(

        //       value: 1,
        //       child: StatefulBuilder(
        //         builder: (BuildContext context,
        //             void Function(void Function()) setState) {
        //           return DoctorsChooseMenu();
        //         },
        //       )),
        // ],
        );
  }

  void clientsMenu(
    BuildContext context,
  ) async {
    print("test here");
    await Provider.of<ClientsProvider>(context, listen: false).get(context);
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
        items: Provider.of<ClientsProvider>(context, listen: false)
            .clients
            .map((client) => PopupMenuItem(
                  onTap: () {
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .changeClientFilter(id: client.id!, name: client.name!);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: mediaWidth > 650 ? 500 : 370,
                        height: 50,
                        // color: check[index] ? primary : Colors.transparent,
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: mediaWidth > 650
                                    ? 1
                                    : .01 * MediaQuery.sizeOf(context).width,
                              ),
                              // Container(
                              //   width: 70,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //       image: DecorationImage(
                              //           image: NetworkImage(
                              //               "https://yama-vet.com/${client.}"),
                              //           fit: BoxFit.cover)),
                              // ),
                              // SizedBox(
                              //   width: mediaWidth > 650
                              //       ? 5
                              //       : .01 * MediaQuery.sizeOf(context).width,
                              // ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/icon_doctor.png",
                                          color:
                                              // check[index] ? Colors.white:
                                              Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          client.name!,
                                          style: TextStyle(
                                              color:
                                                  // check[index]
                                                  //     ?
                                                  // Colors.white
                                                  Colors.black),
                                        ),
                                        SizedBox(
                                          width: mediaWidth > 400
                                              ? .15 *
                                                  MediaQuery.sizeOf(context)
                                                      .width
                                              : .05 * mediaWidth,
                                        ),
                                      ],
                                    ),
                                  ]),
                              Spacer(),
                              // Transform.scale(
                              //   scale: 1.3,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 5),
                              //     child: Checkbox(
                              //       fillColor: MaterialStateProperty.resolveWith(
                              //           (states) {
                              //         if (!states
                              //             .contains(MaterialState.selected)) {
                              //           return Colors.white;
                              //         }
                              //         return null;
                              //       }),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(1)),
                              //       side: BorderSide(
                              //         color: primary,
                              //         width: 1,
                              //       ),
                              //       activeColor:
                              //           check[index] ? Colors.white : primary,
                              //       checkColor:
                              //           check[index] ? primary : Colors.white,
                              //       value: check[index],
                              //       onChanged: (val) async {
                              //         setState(() {
                              //           if (val == true) {
                              //             doctors.add(doctorList[index]);
                              //           } else {
                              //             for (var i = 0;
                              //                 i < doctors.length;
                              //                 i++) {
                              //               if (doctors[i].id ==
                              //                   doctorList[index].id) {
                              //                 doctors.remove(doctors[i]);
                              //               }
                              //             }
                              //           }
                              //
                              //           check[index] = val!;
                              //         });
                              //         Map<String, String> doctorsMap = {};
                              //
                              //         for (int i = 0; i < doctors.length; i++) {
                              //           doctorsMap.addAll({
                              //             'doctors[${i.toString()}][id]':
                              //                 doctors[i].id.toString()
                              //           });
                              //         }
                              //         String encode = json.encode(doctorsMap);
                              //         SharedPreferences sharedPreferences =
                              //             await SharedPreferences.getInstance();
                              //         sharedPreferences.setString(
                              //             'doctoresEncoded', encode);
                              //         print(encode);
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ]),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1.5,
                      ),
                    ],
                  ),
                ))
            .toList()
        // [
        //   PopupMenuItem(

        //       value: 1,
        //       child: StatefulBuilder(
        //         builder: (BuildContext context,
        //             void Function(void Function()) setState) {
        //           return DoctorsChooseMenu();
        //         },
        //       )),
        // ],
        );
  }
// void setDoctors() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//
//   if (sharedPreferences.containsKey('doctoresEncoded')) {
//     String decode = sharedPreferences.getString('doctoresEncoded')!;
//     doctors = jsonDecode(decode);
//   }
//   print("***********$doctors");
// }

// void setClients(List<ClientsModel> clientsList) {
//   clients = clientsList;
// }

// void clietsMenu(BuildContext context) {
//
//   double mediaWidth = MediaQuery.sizeOf(context).width;
//   showMenu(
//     // shadowColor: primary,
//     constraints: BoxConstraints(
//         minWidth: mediaWidth > 650 ? 800.w : 270.w,
//         maxWidth: mediaWidth > 650 ? mediaWidth : 370.w),
//     color: const Color(0xffefefef),
//     // elevation: 5,
//     context: context,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5.sp),
//         side: BorderSide(color: primary)),
//     position: RelativeRect.fromLTRB(mediaWidth > 650 ? 2.w : 1.w,
//         mediaWidth > 400 ? 200.h : 500.h, 1.w, 1.h),
//     items: [
//       PopupMenuItem(
//           onTap: () {
//             setState(() {
//               // text = ' Dr.Benjamin Carter';
//             });
//           },
//           value: 1,
//           child: StatefulBuilder(
//             builder: (BuildContext context,
//                 void Function(void Function()) setState) {
//               return ClientShowMenu(
//
//               );
//             },
//           )),
//     ],
//   );
// }
}
