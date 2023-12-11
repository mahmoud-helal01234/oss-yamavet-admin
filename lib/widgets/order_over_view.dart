import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../controllers/AppointmentsProvider.dart';

class OrderOverViewContainer extends StatefulWidget {
  OrderOverViewContainer({super.key,required this.appointmentIndex});

  int appointmentIndex;
  @override
  State<OrderOverViewContainer> createState() => _OrderOverViewContainerState();
}

class _OrderOverViewContainerState extends State<OrderOverViewContainer> {


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    print("index:"+widget.appointmentIndex.toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: .9 * MediaQuery
          .sizeOf(context)
          .width,
      height: .2 * MediaQuery
          .sizeOf(context)
          .height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primary)),
      child: Column(
        children: [
          Container(
            height : 100,
            child: Consumer<AppointmentsProvider>(
                builder: (context, appointmentsProvider, child) {
                  return ListView.builder(
                    itemCount: appointmentsProvider.appointments[widget
                        .appointmentIndex].appointmentDetails!.length,

                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [

                          Container(
                            height: 100,
                            child: ListView.builder(

                              itemCount: appointmentsProvider.appointments[widget
                                  .appointmentIndex].appointmentDetails![index].services!.length!,
                              itemBuilder: (BuildContext context, int serviceIndex) {
                                return
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child:
                                        Text(
                                            "${appointmentsProvider.appointments[widget
                                                .appointmentIndex].appointmentDetails![index].services![serviceIndex].nameAr} \t"),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "${appointmentsProvider.appointments[widget
                                                  .appointmentIndex].appointmentDetails![index].services![serviceIndex].nameEn} \t")
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            "${appointmentsProvider.appointments[widget
                                                .appointmentIndex].appointmentDetails![index].services![serviceIndex].price}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "\$",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      )
                                    ],
                                  );
                              },
                            ),
                          ),

                        ],
                      );
                    },
                  );
                }
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text("Total",
                    style: TextStyle(
                      fontSize: 15,
                      color: primary,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 10),
                child: Text(
                  "30\$",
                  style: TextStyle(
                      color: primary, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


