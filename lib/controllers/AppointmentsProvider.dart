import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../core/utils/colors.dart';
import '../data/models/dtos/Appointment.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/dtos/AppointmentDetails.dart';
import '../data/models/requests/UpdateAppointmentRequest.dart';
import '../data/models/responses/AppointmentResponse.dart';
import 'package:http/http.dart' as http;
import 'package:yama_vet_admin/core/utils/strings.dart';

import '../data/services/ApiService.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<Appointment> appointments = [];
  List<bool> appointmentsShown = [];

  void replace(List<Appointment> newAppointments) {
    appointments = newAppointments;
    notifyListeners();
  }

  String? statusFilter;

  UpdateAppointmentRequest? updateAppointmentRequest;

  int? selectedPetId = 0;

  void toggleServiceIdToPetForUpdateAppointmentRequest(int serviceId) {
    for (int index = 0;
        index < updateAppointmentRequest!.petIds!.length;
        index++) {
      if (selectedPetId == updateAppointmentRequest!.petIds![index].petId) {
        for (int serviceIndex = 0;
            serviceIndex <
                updateAppointmentRequest!.petIds![index].serviceIds!.length;
            serviceIndex++) {
          if (updateAppointmentRequest!
                  .petIds![index].serviceIds![serviceIndex] ==
              serviceId) {
            updateAppointmentRequest!.petIds![index].serviceIds!
                .removeAt(serviceIndex);
            notifyListeners();
            return;
          }
        }
        updateAppointmentRequest!.petIds![index].serviceIds!.add(serviceId);
        notifyListeners();
        return;
      }
    }
  }

  void initiateUpdateAppointmentRequest(int appointmentIndex) {
    List<PetIds> petIds = [];
    for (int index = 0;
        index < appointments[appointmentIndex].appointmentDetails!.length;
        index++) {
      List<int> petServices = [];
      for (int serviceIndex = 0;
          serviceIndex <
              appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services!
                  .length;
          serviceIndex++) {
        petServices.add(appointments[appointmentIndex]
            .appointmentDetails![index]
            .services![serviceIndex]
            .id!);
      }

      petIds.add(PetIds(
          petId: appointments[appointmentIndex]
              .appointmentDetails![index]
              .pet!
              .id!,
          serviceIds: petServices));
    }

    updateAppointmentRequest = UpdateAppointmentRequest(
        id: appointments[appointmentIndex].id.toString(),
        locationId: 4.toString(),
        price: appointments[appointmentIndex].price,
        petIds: petIds);
  }

  void selectPet(int newPetId) {
    selectedPetId = newPetId;
    notifyListeners();
  }

  void filterAppointments() {
    appointmentsShown = List.filled(appointments.length, true, growable: true);

    for (int index = 0; index < appointments.length; index++) {
      if (statusFilter != null && appointments[index].status != statusFilter) {
        appointmentsShown[index] = false;
        continue;
      }
    }
    notifyListeners();
  }

  Future<void> getAppointments(BuildContext context) async {
    appointmentsShown = List.filled(appointments.length, true, growable: true);
    AppointmentsResponse appointmentsResponse = AppointmentsResponse.fromJson(
        await ApiService().get("appointment",
            context: context, componentName: "Appointment"));

    appointments = appointmentsResponse.data!;
    filterAppointments();
    notifyListeners();
  }

  Future<void> changeCashStatusByIndex(
      BuildContext context, int appointmentIndex, String cashStatus) async {
    await ApiService().getAction(
        "appointment/cash?id=${appointments[appointmentIndex].id!}&status=${appointments[appointmentIndex].status!}",
        context: context,
        componentName: "Appointment",
        actionName: " Status changed");
    appointments[appointmentIndex].cash = cashStatus;
    filterAppointments();
    notifyListeners();
  }

  // Future update(BuildContext context,AddAppointmentRequest addAppointmentRequest) async {
  //
  //   await ApiService().post("appointment",
  //       addAppointmentRequest.toJson(), context:context,componentName: "Appointment");
  //
  //   getAppointments(context);
  // }

  Future update(BuildContext context,
      UpdateAppointmentRequest updateAppointmentRequest) async {
    await ApiService().post(
        "appointment/update", updateAppointmentRequest.toJson(),
        context: context,
        componentName: "Appointment",
        operationName: "Updated");

    await getAppointments(context);
    filterAppointments();
  }

  Future accept(BuildContext context, int index) async {

    await ApiService().getAction(
        "appointment/accept/${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].id!}",
        context: context,
        componentName: "Appointment",actionName: "Accepted");
    getAppointments(context);
    Navigator.pop(context);

  }

  void changeAppointmentStatusByIndex(int index, String status) {
    appointments[index].status = status;
    filterAppointments();
    notifyListeners();
  }

  changeStatusFilter(String status) {
    statusFilter = status;
    filterAppointments();
  }

  Future<void> delete(BuildContext context, int appointmentIndex) async {
    await ApiService().delete("appointment", appointments[appointmentIndex].id!,
        context: context, componentName: "User");
    Navigator.pop(context);
    appointments.removeAt(appointmentIndex);
    appointmentsShown.removeAt(appointmentIndex);

    notifyListeners();
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Appointment Deleted Successfully',
        autoCloseDuration: const Duration(seconds: 3),
        showConfirmBtn: true,
        confirmBtnColor: primary);
  }

  isServiceIdForSelectedPetIdAndAppointmentUpdateRequest(int serviceId) {
    print("tested");

    for (int i = 0; i < updateAppointmentRequest!.petIds!.length; i++) {
      if (updateAppointmentRequest!.petIds![i].petId == selectedPetId) {
        print(updateAppointmentRequest!.petIds![i].petId.toString() +
            " == " +
            selectedPetId.toString());
        for (int serviceIndex = 0;
            serviceIndex <
                updateAppointmentRequest!.petIds![i].serviceIds!.length;
            serviceIndex++) {
          if (serviceId ==
              updateAppointmentRequest!.petIds![i].serviceIds![serviceIndex]) {
            print(updateAppointmentRequest!.petIds![i].serviceIds![serviceIndex]
                    .toString() +
                " == " +
                serviceId.toString());

            return true;
          }
        }
      }
    }
    return false;
  }
}
