import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Provider.of<AppointmentsProvider>(context, listen: false)
                .launchLocationOnGoogleMap(
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .appointments![widget.appointmentIndex]
                        .clientLocation!
                        .latitude
                        .toString(),
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .appointments![widget.appointmentIndex]
                        .clientLocation!
                        .longitude
                        .toString());
          },
          child: Container(
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 27,
                ),
                Consumer<AppointmentsProvider>(
                    builder: (context, appointmentsProvider, child) {
                  return SizedBox(
                    width: 0.5.sw,
                    child: Text(
                      appointmentsProvider.appointments[widget.appointmentIndex]
                          .clientLocation!.description!,
                      style: TextStyle(
                        fontSize: mediaWidth > 650 ? 20 : 13,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        Consumer<AppointmentsProvider>(
            builder: (context, appointmentsProvider, child) {
          return (Provider.of<SettingsProvider>(context, listen: true).role !=
                  "vet")
              ? Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: primary, width: 1.5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Consumer<AppointmentsProvider>(builder:
                                  (context, appointmentsProvider, child) {
                                return Text(
                                  appointmentsProvider
                                                  .appointments[
                                                      widget.appointmentIndex]
                                                  .cash! ==
                                              "collected" ||
                                          appointmentsProvider
                                                  .appointments[
                                                      widget.appointmentIndex]
                                                  .cash! ==
                                              "not_collected"
                                      ? appointmentsProvider
                                          .appointments[widget.appointmentIndex]
                                          .cash!
                                          .tr()
                                      : appointmentsProvider
                                          .appointments[widget.appointmentIndex]
                                          .cash!,
                                  style: TextStyle(
                                      fontFamily: 'futur',
                                      fontSize: mediaWidth > 650 ? 15 : 12,
                                      color: primary),
                                );
                              }),
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
                                  position: const RelativeRect.fromLTRB(
                                      220, 270, 220, 4),
                                  items: [
                                    PopupMenuItem(
                                        onTap: () {
                                          Provider.of<AppointmentsProvider>(
                                                  context,
                                                  listen: false)
                                              .changeCashStatusByIndex(
                                                  context,
                                                  widget.appointmentIndex,
                                                  "collected");
                                        },
                                        value: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    "collected".tr(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )),
                                    PopupMenuItem(
                                        onTap: () {
                                          Provider.of<AppointmentsProvider>(
                                                  context,
                                                  listen: false)
                                              .changeCashStatusByIndex(
                                                  context,
                                                  widget.appointmentIndex,
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
                                                Text(
                                                  "not_collected".tr(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            );
                                          },
                                        ))
                                  ]);
                            },
                            child: const Icon(Icons.keyboard_arrow_down_sharp)),
                      ]))
              : Container();
        }),
      ],
    );
  }
}
