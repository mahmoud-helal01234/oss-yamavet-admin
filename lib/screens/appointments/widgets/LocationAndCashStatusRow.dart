import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/dtos/Appointment.dart';

import '../../../controllers/AppointmentsProvider.dart';
import '../../../controllers/SettingsProvider.dart';

class LocationAndCashStatusRow extends StatefulWidget {
  LocationAndCashStatusRow({super.key, required this.appointmentIndex});

  bool status = false;
  final int appointmentIndex;

  @override
  State<LocationAndCashStatusRow> createState() =>
      _LocationAndCashStatusRowState();
}

class _LocationAndCashStatusRowState extends State<LocationAndCashStatusRow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery
        .sizeOf(context)
        .height; //!900
    double mediaWidth = MediaQuery
        .sizeOf(context)
        .width;
    return Row(
      children: [

        InkWell(
          onTap: (){
            Provider.of<AppointmentsProvider>(context, listen: false)
                .launchLocationOnGoogleMap(Provider.of<AppointmentsProvider>(context, listen: false)
              .appointments![widget.appointmentIndex].clientLocation!.latitude.toString(),
                Provider.of<AppointmentsProvider>(context, listen: false)
                    .appointments![widget.appointmentIndex].clientLocation!.longitude.toString()
            );
          },
          child: Container(

            child: Row(children: [SizedBox(
              width: mediaWidth > 400
                  ? .05 * MediaQuery
                  .sizeOf(context)
                  .width
                  : .01 * mediaWidth,
            ),
              const Icon(
                Icons.location_on,
                size: 27,
              ),
              Consumer<AppointmentsProvider>(
                  builder: (context, appointmentsProvider, child) {
                    return Text(
                      appointmentsProvider.appointments[widget.appointmentIndex]
                          .clientLocation!.description!,
                      style: TextStyle(
                        fontSize: mediaWidth > 650 ? 20 : 13,
                      ),
                    );
                  }
              ),
            ],),
          ),
        ),

        Spacer(),

         Consumer<AppointmentsProvider>(
            builder: (context, appointmentsProvider, child) {
              return (Provider.of<SettingsProvider>(context, listen: true).role != "vet")?Container(
                  margin: EdgeInsets.only(right: mediaWidth > 650 ? 30 : 20),
                  // width: appointmentsProvider.appointments[widget.appointmentIndex].cash == "not_collected"
                  //     ? mediaWidth > 650
                  //         ? 170
                  //         : .34 * mediaWidth
                  //     : 150,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: primary, width: 1.5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Row(
                            children: [
                              Text(
                                "Cash:",
                                style: TextStyle(
                                    fontFamily: 'futur',
                                    fontSize: mediaWidth > 650 ? 20 : 15,
                                    color: Colors.black),
                              ),
                              Consumer<AppointmentsProvider>(
                                  builder: (context, appointmentsProvider,
                                      child) {
                                    return Text(
                                      appointmentsProvider.appointments[widget
                                          .appointmentIndex].cash!,
                                      style: TextStyle(
                                          fontFamily: 'futur',
                                          fontSize: mediaWidth > 650 ? 15 : 12,
                                          color: primary),
                                    );
                                  }
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              showMenu(
                                // shadowColor: primary,
                                  constraints: const BoxConstraints(
                                      maxWidth: 160, maxHeight: 150),
                                  color: const Color(0xffefefef),
                                  // elevation: 5,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: primary)),
                                  position:
                                  const RelativeRect.fromLTRB(150, 270, 1, 4),
                                  items: [
                                    PopupMenuItem(
                                        onTap: () {
                                          Provider.of<AppointmentsProvider>(
                                              context, listen: false)
                                              .changeCashStatusByIndex(
                                              context, widget.appointmentIndex,
                                              "collected");
                                        },
                                        value: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                              setState) {
                                            return const Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    "Collected",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        fontSize: 15),
                                                  ),
                                                ),

                                              ],
                                            );
                                          },
                                        )),
                                    PopupMenuItem(
                                        onTap: () {
                                          Provider.of<AppointmentsProvider>(
                                              context, listen: false)
                                              .changeCashStatusByIndex(
                                              context, widget.appointmentIndex,
                                              "not_collected");
                                        },
                                        value: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                              setState) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Not collected",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 12),
                                                ),

                                              ],
                                            );
                                          },
                                        ))
                                  ]);
                            },
                            child: const Icon(Icons.keyboard_arrow_down_sharp)),
                      ])):Container();
            }
        ),
      ],
    );
  }
}
