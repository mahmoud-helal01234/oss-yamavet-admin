
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/AppointmentsProvider.dart';
import 'stepper.dart';
import '../utils/colors.dart';
import '../../data/models/offers_model.dart';

List<OffersModel> offerList = [];
Future<void> dialogBuilder(
    BuildContext context,
    String img,
    void Function()? onDeletePress,
    Widget customWidget,
    void Function()? onUpdatePress) {
  double mediaHeight = MediaQuery.sizeOf(context).height; //!900
  double mediaWidth = MediaQuery.sizeOf(context).width; //!400
  return showDialog<void>(

      // barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

              Card(
                  // margin: EdgeInsets.only(
                  //   top: mediaWidth > 650 ? .6 * mediaHeight : .5 * mediaHeight,
                  // ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  elevation: 30,
                  // color: Colors.white,
                  child: Container(
                    width: mediaWidth,
                    height: .42 * mediaHeight,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              spreadRadius: 1,
                              blurRadius: 20)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: mediaWidth > 650 ? 20 : 10,
                        ),
                        Container(
                          width: .5 * mediaWidth,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(img), fit: BoxFit.cover)),
                          // child: Image.network(
                          //   img,
                          //   width: 150,
                          //   fit: BoxFit.fitWidth,
                          //   // height: mediaWidth > 650 ? 200 : 120,
                          //   // fit: BoxFit.fitHeight,
                          // ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 4,
                            right: 4,
                            child: Container(
                              height: mediaWidth > 650 ? 30 : 25,
                              width: 285,
                              decoration: const BoxDecoration(
                                  color: Color(0xff213442),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Change Image",
                                          style: TextStyle(
                                              fontFamily: 'futur',
                                              color: Colors.white,
                                              fontSize:
                                                  mediaWidth > 650 ? 20 : 15),
                                        ),
                                        customWidget,
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )),
                        SizedBox(
                          height: mediaWidth > 650 ? 20 : 10,
                        ),
                        Container(
                          height: mediaWidth > 650 ? 40 : 30,
                          width: .75 * mediaWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5, left: 4),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'www.exmple.com/image.jpg',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaWidth > 650 ? 10 : 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              elevation: 10,
                              minWidth: mediaWidth > 650 ? 200 : 140,
                              height: mediaWidth > 650 ? 35 : 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: const Color(0xffba94b9),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontFamily: 'futur',
                                      color: Colors.white,
                                      fontSize: mediaWidth > 650 ? 22 : 15)),
                            ),
                            SizedBox(
                              width: mediaWidth > 650 ? 30 : 10,
                            ),
                            MaterialButton(
                              elevation: 10,
                              minWidth: mediaWidth > 650 ? 200 : 140,
                              height: mediaWidth > 650 ? 35 : 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: primary,
                              onPressed: onUpdatePress,
                              child: Text("Update",
                                  style: TextStyle(
                                      fontFamily: 'futur',
                                      color: Colors.white,
                                      fontSize: mediaWidth > 650 ? 22 : 15)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaWidth > 650 ? 10 : 0,
                        ),
                        MaterialButton(
                          elevation: 10,
                          minWidth: mediaWidth > 650 ? 400 : 140,
                          height: mediaWidth > 650 ? 35 : 25,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Colors.red,
                          onPressed: onDeletePress,
                          child: Text("Delete",
                              style: TextStyle(
                                  fontFamily: 'futur',
                                  color: Colors.white,
                                  fontSize: mediaWidth > 650 ? 22 : 15)),
                        ),

                      ]),
                    ),
                  ))
            ]));
      });
}

Future<void> dialogBuilderOrder(BuildContext context, TextAlign textAlign, int appointmentIndex, void Function() onPress) {

  double mediaHeight = MediaQuery.sizeOf(context).height; //!900
  double mediaWidth = MediaQuery.sizeOf(context).width; //!400

  return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.only(
                      top: mediaWidth > 650
                          ? .6 * mediaHeight
                          : .56 * mediaHeight),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  elevation: 30,
                  // color: Colors.white,
                  child: Container(
                    width: mediaWidth,
                    height: .38 * mediaHeight,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: primary,
                        boxShadow: []),
                    child: Stack(
                      children: [
                        Positioned(
                            left: 20,
                            top: 10,
                            child: Container(
                              width: .03 * MediaQuery.sizeOf(context).width,
                              height: mediaHeight > 900
                                  ? .37 * mediaHeight
                                  : .35 * MediaQuery.sizeOf(context).height,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            )),
                        Positioned(
                            top: mediaWidth > 650 ? 30 : 20,
                            left: mediaHeight > 900 ? 60 : 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Consumer<AppointmentsProvider>(
                                        builder: (context, appointmentsProvider, child) {
                                          return Text(
                                          "Order #${appointmentsProvider.appointments[appointmentIndex].id.toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'futuraMd',
                                              fontSize: mediaWidth > 650 ? 20 : 15,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    ),
                                    SizedBox(
                                      width: mediaWidth > 650
                                          ? .7 * mediaWidth
                                          : .5 *
                                              MediaQuery.sizeOf(context).width,
                                    ),
                                    Consumer<AppointmentsProvider>(
                                        builder: (context, appointmentsProvider, child) {
                                          return Text(
                                          "${appointmentsProvider.appointments[appointmentIndex].price}\$",
                                          style: TextStyle(
                                              fontSize: mediaWidth > 650 ? 20 : 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: mediaWidth > 650 ? 20 : 10,
                                ),
                                SizedBox(
                                  height: mediaWidth > 650 ? 20 : 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      weight: 30,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Consumer<AppointmentsProvider>(
                                        builder: (context, appointmentsProvider, child) {
                                          return Text(
                                              appointmentsProvider.appointments[appointmentIndex]!.day!,
                                          style: GoogleFonts.roboto(
                                              fontSize: mediaWidth > 650 ? 20 : 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        );
                                      }
                                    ),
                                    SizedBox(
                                      width: mediaHeight > 900
                                          ? .4 * mediaWidth
                                          : .3 *
                                              MediaQuery.sizeOf(context).width,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mediaWidth > 650 ? 20 : 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Consumer<AppointmentsProvider>(
                                        builder: (context, appointmentsProvider, child) {
                                          return Text(
                                          appointmentsProvider.appointments[appointmentIndex].clientLocation!.description!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mediaWidth > 650 ? 20 : 15,
                                          ),
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Positioned(
                            left: mediaHeight > 900
                                ? 300
                                : mediaWidth > 350
                                    ? 60
                                    : 40,
                            bottom: mediaWidth > 650 ? 120 : 70,
                            child: Consumer<AppointmentsProvider>(
                                builder: (context, appointmentsProvider, child) {
                                  return StepperScreen(
                                  lineColor: Colors.white,
                                  stepperColor: Colors.red,
                                  textColor: Colors.white,
                                  status: appointmentsProvider.appointments[appointmentIndex]!.status!,
                                );
                              }
                            )),
                        Consumer<AppointmentsProvider>(
                            builder: (context, appointmentsProvider, child) {
                              return appointmentsProvider.appointments[appointmentIndex].status == "initiated" ? Positioned(
                              bottom: 20,
                              left: mediaWidth > 650 ? 200 : 40,
                              child: MaterialButton(
                                color: Colors.white,
                                minWidth: mediaWidth > 650 ? 470 : 300,
                                height: 30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: onPress,
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                            ):Container();
                          }
                        )
                      ],
                    ),
                  ),
                )
              ]),
        );
      });
}
