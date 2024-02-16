import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class AppointmentCashStatusFilter extends StatelessWidget {
  const AppointmentCashStatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Center(
      child: Container(
        height: 35,
        width: mediaWidth,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .changeCashStatusFilter("collected");
                  },
                  child: Container(
                    width: mediaWidth > 650 ? 120 : 100,
                    decoration: BoxDecoration(
                        color: Provider.of<AppointmentsProvider>(context,
                                        listen: true)
                                    .cashStatusFilter ==
                                "collected"
                            ? primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: primary, width: 1.5)),
                    child: Center(
                      child: Text(
                        "collected".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'futur',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<AppointmentsProvider>(context, listen: false)
                        .changeCashStatusFilter("not_collected");
                  },
                  child: Container(
                    width: mediaWidth > 650 ? 130 : 110,
                    decoration: BoxDecoration(
                        color: Provider.of<AppointmentsProvider>(context,
                                        listen: true)
                                    .cashStatusFilter ==
                                "not_collected"
                            ? primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: primary, width: 1.5)),
                    child: Center(
                      child: Text(
                        "not_collected".tr(),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futur',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
