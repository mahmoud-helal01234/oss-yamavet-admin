import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

import '../../../controllers/AppointmentsProvider.dart';
import '../../../data/models/dtos/AppointmentDetails.dart';
import '../../../data/models/requests/UpdateAppointmentRequest.dart';


class AppointmentPet extends StatefulWidget {
  const AppointmentPet({super.key, required this.appointmentIndex, required this.appointmentDetailsIndex});
  final int? appointmentIndex;
  final int? appointmentDetailsIndex;

  @override
  State<AppointmentPet> createState() => _AppointmentPetState();
}

class _AppointmentPetState extends State<AppointmentPet> {
  bool ontap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Provider.of<AppointmentsProvider>(context, listen: false)
              .selectPet(Provider.of<AppointmentsProvider>(context, listen: false).
          appointments[widget.appointmentIndex!].appointmentDetails![widget.appointmentDetailsIndex!].pet!.id!);


        });
        // Provider.of<AppointmentsProvider>(context, listen: false)
        //     .selectPet(AppointmentDetails());
      },
      child: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
            return Container(
            margin: EdgeInsets.only(left: 15),
            width: 70,
            height: 100,
            decoration: BoxDecoration(
                color: appointmentsProvider.
                appointments[widget.appointmentIndex!].
                appointmentDetails![widget.appointmentDetailsIndex!].pet!.id!
                    == appointmentsProvider.selectedPetId ? primary : lightgray,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                  NetworkImage(
                      "https://yama-vet.com/${appointmentsProvider.appointments[widget.appointmentIndex!].appointmentDetails![widget.appointmentDetailsIndex!].pet!.imgPath}"),

                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  appointmentsProvider.appointments[widget.appointmentIndex!].appointmentDetails![widget.appointmentDetailsIndex!].pet!.name!,
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: !ontap ? Colors.black : Colors.white),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
