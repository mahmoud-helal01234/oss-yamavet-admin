import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/helper/dialog.dart';
import 'package:yama_vet_admin/core/helper/stepper.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/appoint_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/appointments/order_review.dart';

import '../../../controllers/AppointmentsProvider.dart';

class AppointmentContainer extends StatefulWidget {
  AppointmentContainer({
    super.key,
    required this.textEmergancy,
    required this.textColor,
    required this.textalign,
    required this.paddingtext,
    required this.init,
    required this.pic,
  });

  final String textEmergancy;
  final Color textColor;
  final TextAlign textalign;
  final EdgeInsetsGeometry paddingtext;
  final bool init;
  final double pic;

  @override
  State<AppointmentContainer> createState() => _AppointmentContainerState();
}

class _AppointmentContainerState extends State<AppointmentContainer> {
  AppointModel? appointModel;

  // TestModel? testModel;
  Api api = Api();
  bool? _isLoading;

  @override
  void initState() {
    super.initState();

    getAllAppointmets();
  }

  Future<void> getAllAppointmets() async {
    await Provider.of<AppointmentsProvider>(context, listen: false)
        .getAppointments(context);
  }

  // Future<void> getTestApp() async {
  //   testList = await api.getTest();
  //   setState(() {});
  // }

  bool onTap = false;
  int? ddd;
  bool active = false;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return Container(
      width: mediaWidth,
      height: mediaWidth > 650 ? 450.h : 390.h,
      child: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
        return ListView.builder(
          itemCount: appointmentsProvider.appointments.length,
          itemBuilder: (BuildContext context, int index) {
            return
                // !appointmentsProvider.appointmentsShown[index]
                //   ? Container() :
                Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OrderReview(
                                    appointmentIndex: index,
                                    onTap: () {
                                      setState(() {
                                        onTap = !onTap;
                                      });
                                    },
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      elevation: 10,
                      child: Container(
                        width: .9 * MediaQuery.sizeOf(context).width,
                        height: !widget.init
                            ? .3 * mediaHeight
                            : .37 * MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                          color: lightgray,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Center(
                    child: Text(
                      appointmentsProvider.appointments![index].cash!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )),
                Positioned(
                    left: 20,
                    top: 10,
                    child: Container(
                      width: .03 * MediaQuery.sizeOf(context).width,
                      height: mediaHeight > 900
                          ? .37 * mediaHeight
                          : .37 * MediaQuery.sizeOf(context).height,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    )),
                Positioned(
                    top: mediaWidth > 650 ? 40 : 30,
                    left: mediaHeight > 900 ? 60 : 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              " ${"Order".tr()} #${appointmentsProvider.appointments![index].appointmentNumber.toString()}",
                              style: TextStyle(
                                  fontFamily: 'futuraMd',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: mediaWidth > 650
                                  ? .6 * mediaWidth
                                  : .4 * MediaQuery.sizeOf(context).width,
                            ),
                            Text(
                              "${appointmentsProvider.appointments![index].price}\$",
                              style: TextStyle(
                                  color: primary, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Padding(
                        //     padding: (appointmentsProvider.appointments![index].type != 'emergancy')?widget.paddingtext: EdgeInsets.only(left: 100,right: 100),
                        //     child:  (appointmentsProvider.appointments![index].type == 'emergancy')?Text("Vet Emergency",style: TextStyle(color: Colors.red,fontSize: 20),):Row(
                        //       children:betName(index),
                        //     )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              weight: 30,
                            ),
                            Text(
                              "${appointmentsProvider.appointments![index].day}",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: mediaHeight > 900
                                  ? .57 * mediaWidth
                                  : .16 * MediaQuery.sizeOf(context).width,
                            ),
                            widget.pic > 1
                                ? Stack(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 55,
                                        child: Image.asset(
                                          "assets/images/spoty.png",
                                          width: 50,
                                          height: 40,
                                        ),
                                      ),
                                      Positioned(
                                        right: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, right: 6, top: 2),
                                          child: Image.asset(
                                            "assets/images/fluffy.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: betimg(index),
                                  )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print("off a7");
                            Provider.of<AppointmentsProvider>(context,
                                    listen: false)
                                .launchLocationOnGoogleMap(
                                    appointmentsProvider.appointments![index]
                                        .clientLocation!.latitude
                                        .toString(),
                                    appointmentsProvider.appointments![index]
                                        .clientLocation!.longitude
                                        .toString());
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 27,
                              ),
                              Text(
                                  "${appointmentsProvider.appointments![index].clientLocation!.description}")
                            ],
                          ),
                        ),
                        appointmentsProvider.appointments![index].status !=
                                    'initiated' &&
                                appointmentsProvider
                                        .appointments![index].doctor !=
                                    null
                            ? Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        appointmentsProvider
                                                        .appointments![index]
                                                        .doctor !=
                                                    null &&
                                                appointmentsProvider
                                                        .appointments![index]
                                                        .doctor!
                                                        .imgPath !=
                                                    null
                                            ? Container(
                                                width: 50,
                                                height: 50,
                                                child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: NetworkImage(
                                                        "https://yama-vet.com/${appointmentsProvider.appointments![index].doctor!.imgPath}")),
                                              )
                                            : Container(),
                                        // Image.asset("assets/images/dr.png"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Image.asset(
                                        //     "assets/images/icon_doctor.png"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "Dr ${appointmentsProvider.appointments![index].doctor!.name!}"),
                                        SizedBox(
                                          width: mediaHeight > 900
                                              ? .45 * mediaWidth
                                              : .09 *
                                                  MediaQuery.sizeOf(context)
                                                      .width,
                                        ),
                                        // const Text(
                                        //   "Rating",
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w500),
                                        // ),
                                        // Icon(
                                        //   Icons.star,
                                        //   color: Colors.yellow[600],
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    )),
                Positioned(
                    left: 70.w,
                    bottom: mediaWidth > 650 ? 90.h : 25.h,
                    child: StepperScreen(
                        lineColor: primary,
                        stepperColor: primary,
                        textColor: Colors.black,
                        status:
                            appointmentsProvider.appointments![index].status!)),
                Positioned(
                    bottom: 0,
                    left: .4 * MediaQuery.sizeOf(context).width,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, orderReview);
                      },
                      child: GestureDetector(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setInt('appointId',
                              appointmentsProvider.appointments![index].id!);
                          // ignore: use_build_context_synchronously
                          dialogBuilderOrder(context, widget.textalign, index
                              // activeList[index],
                              );
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Moredetails".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          },
        );
      }),
    );
  }

  // List<Widget> betName(int index) {
  //   List<Widget> names = [];
  //   Provider.of<AppointmentsProvider>(context, listen: false).appointments;
  //
  //   for (var i = 0;
  //       i <
  //           Provider.of<AppointmentsProvider>(context, listen: false)
  //               .appointments[index]
  //               .petsImages!
  //               .length;
  //       i++) {
  //     names.add(Text(
  //         "${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].appointmentDetails![i].pet!.name} \t"));
  //   }
  //   return names;
  // }

  List<Widget> betimg(int index) {
    List<Widget> imgs = [];
    for (var i = 0;
        i <
            Provider.of<AppointmentsProvider>(context, listen: false)
                .appointments[index]
                .appointmentDetails!
                .length;
        i++) {
      // imgs.add(
      //     );
    }
    return imgs;
  }

  List<Widget> betNameBuilder(int index) {
    List<Widget> names = [];
    for (var i = 0;
        i <
            Provider.of<AppointmentsProvider>(context, listen: false)
                .appointments[index]
                .appointmentDetails!
                .length;
        i++) {
      names.add(Text(
        "${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].appointmentDetails![i].pet!.name.toString()} \t",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ));
    }
    return names;
  }

  List<Widget> betNameOverview(int index) {
    List<Widget> names = [];
    for (var i = 0;
        i <
            Provider.of<AppointmentsProvider>(context, listen: false)
                .appointments[index]
                .appointmentDetails!
                .length;
        i++) {
      names.add(Row(
        children: [
          SizedBox(
            width: 13,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].appointmentDetails![i].pet!.name.toString()} \t"),
          ),
        ],
      ));
    }
    return names;
  }
}
