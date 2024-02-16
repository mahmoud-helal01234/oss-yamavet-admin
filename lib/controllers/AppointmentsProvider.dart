import 'dart:collection';
import 'dart:developer' as dartDev;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';

import '../core/utils/colors.dart';
import '../data/models/dtos/Appointment.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import '../data/models/dtos/Service.dart';
import '../data/models/requests/UpdateAppointmentRequest.dart';
import '../data/models/responses/AppointmentResponse.dart';

import '../data/models/responses/CategoriesResponse.dart';
import '../data/services/ApiService.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<Appointment> appointments = [];

  // List<bool> appointmentsShown = [];

  String? statusFilter;

  String? cashStatusFilter;

  int? doctorIdFilter;
  String? selectedDoctorName;

  int? clientIdFilter;
  String? selectedClientName;

  DateTime? from;
  DateTime? to;

  UpdateAppointmentRequest? updateAppointmentRequest;

  int? selectedPetId = 0;

  getPetNameByIdFrom() {}

  void launchLocationOnGoogleMap(String lat, String long) {
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    launchUrl(Uri.parse(url));
  }

  // void filterAppointments() {
  //   // appointmentsShown = List.filled(appointments.length, true, growable: true);
  //
  //   for (int index = 0; index < appointments.length; index++) {
  //     // if (statusFilter != null && appointments[index].status != statusFilter) {
  //     //   appointmentsShown[index] = false;
  //     //   continue;
  //     // }
  //
  //     // if (doctorIdFilter != null && appointments[index].doctor != null && appointments[index].doctor. != null != statusFilter) {
  //     //   appointmentsShown[index] = false;
  //     //   continue;
  //     // }
  //     if (doctorNameFilter != null && appointments[index].doctor != null &&
  //         appointments[index].doctor!.name! != null &&
  //         appointments[index].doctor!.name! != doctorNameFilter) {
  //       // appointmentsShown[index] = false;
  //       continue;
  //     }
  //   }
  //   notifyListeners();
  // }

  void clearFilters(context) {
    statusFilter = null;
    doctorIdFilter = null;

    from = null;
    cashStatusFilter = null;
    to = null;
    selectedDoctorName = null;
    selectedClientName = null;
    getAppointments(context);
    notifyListeners();
  }

  String _getFilterQueryParams() {
    String queryParam = "?";
    if (statusFilter != null) {
      queryParam += "status=${statusFilter!}&";
    }

    if (cashStatusFilter != null) {
      queryParam += "cash=${cashStatusFilter!}&";
    }

    if (doctorIdFilter != null) {
      queryParam += "doctor_id=[${doctorIdFilter!}]&";
    }

    if (from != null) {
      queryParam += "from=${DateFormat('yyyy-MM-dd').format(from!)}&";
    }

    if (to != null) {
      queryParam += "to=${DateFormat('yyyy-MM-dd').format(to!)}&";
    }

    return queryParam;
  }

  double totalPrice = 0;

  Future<void> getAppointments(BuildContext context) async {
    // appointmentsShown = List.filled(appointments.length, true, growable: true);
    print("link: " + "appointment${_getFilterQueryParams()}");
    AppointmentsResponse appointmentsResponse = AppointmentsResponse.fromJson(
        await ApiService().get("appointment${_getFilterQueryParams()}",
            context: context, componentName: "Appointment"));

    appointments = appointmentsResponse.data!;
    totalPrice = 0;
    appointments.forEach((element) {
      totalPrice += element.price!;
    });

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
    // filterAppointments();
    notifyListeners();
  }

  Future update(BuildContext context) async {
    await ApiService().post(
        "appointment/update", updateAppointmentRequest!.toJson(),
        context: context,
        componentName: "Appointment",
        operationName: "Updated");

    getAppointments(context);
  }

  Future accept(BuildContext context, int index) async {
    await ApiService().getAction(
        "appointment/accept/${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].id!}",
        context: context,
        componentName: "Appointment",
        actionName: "Accepted");
    getAppointments(context);
    Navigator.pop(context);
  }

  Future complete(BuildContext context, int index) async {
    await ApiService().getAction(
        "appointment/complete/${Provider.of<AppointmentsProvider>(context, listen: false).appointments[index].id!}",
        context: context,
        componentName: "Appointment",
        actionName: "Completed");
    getAppointments(context);
    Navigator.pop(context);
  }

  void changeAppointmentStatusByIndex(int index, String status) {
    appointments[index].status = status;

    notifyListeners();
  }

  changeStatusFilter(String status) {
    statusFilter = status;
    notifyListeners();
  }

  changeCashStatusFilter(String cashStatus) {
    cashStatusFilter = cashStatus;
    notifyListeners();
  }

  changeFromFilter(DateTime newFrom) {
    from = newFrom;
    notifyListeners();
  }

  changeToFilter(DateTime newTo) {
    to = newTo;
    notifyListeners();
  }

  changeDoctorFilter({required int id, required String name}) {
    doctorIdFilter = id;
    selectedDoctorName = name;
    notifyListeners();
  }

  changeClientFilter({required int id, required String name}) {
    clientIdFilter = id;
    selectedClientName = name;
    notifyListeners();
  }

  Future<void> delete(BuildContext context, int appointmentIndex) async {
    await ApiService().delete("appointment", appointments[appointmentIndex].id!,
        context: context, componentName: "User");
    Navigator.pop(context);
    appointments.removeAt(appointmentIndex);
    // appointmentsShown.removeAt(appointmentIndex);

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
    for (int i = 0; i < updateAppointmentRequest!.petIds!.length; i++) {
      if (updateAppointmentRequest!.petIds![i].petId == selectedPetId) {
        return updateAppointmentRequest!.petIds![i].services!
            .containsKey(serviceId);
      }
    }
    return false;
  }

  void initiateUpdateAppointmentRequest(int appointmentIndex) {
    updateAppointmentRequest = null;
    print("initiateUpdateAppointmentRequest");
    List<PetIds> petIds = [];
    selectedPetId =
        appointments[appointmentIndex].appointmentDetails![0].pet!.id!;
    for (int index = 0;
        index < appointments[appointmentIndex].appointmentDetails!.length;
        index++) {
      HashMap<int, Service>? petServices = HashMap<int, Service>();

      for (int serviceIndex = 0;
          serviceIndex <
              appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services!
                  .length;
          serviceIndex++) {
        petServices!.putIfAbsent(
            appointments[appointmentIndex]
                .appointmentDetails![index]
                .services![serviceIndex]
                .id!, () {
          return Service(
              id: appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services![serviceIndex]
                  .id,
              price: appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services![serviceIndex]
                  .price,
              nameEn: appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services![serviceIndex]
                  .nameEn,
              nameAr: appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services![serviceIndex]
                  .nameAr,
              categoryId: appointments[appointmentIndex]
                  .appointmentDetails![index]
                  .services![serviceIndex]
                  .categoryId);
        });
      }
      petServices.forEach((key, value) {
        print("key " + key.toString() + " - " + value.nameEn!);
      });
      petIds.add(PetIds(
          pet: appointments[appointmentIndex].appointmentDetails![index].pet!,
          petId: appointments[appointmentIndex]
              .appointmentDetails![index]
              .pet!
              .id!,
          services: petServices));
    }

    updateAppointmentRequest = UpdateAppointmentRequest(
        id: appointments[appointmentIndex].id.toString(), petIds: petIds);

    notifyListeners();
    dartDev.log("updateAppointmentRequest:");
    dartDev.log(jsonEncode(updateAppointmentRequest!.toJson()));
  }

  void toggleServiceIdToPetForUpdateAppointmentRequest(
      int serviceId, Service service) {
    for (int index = 0;
        index < updateAppointmentRequest!.petIds!.length;
        index++) {
      if (selectedPetId == updateAppointmentRequest!.petIds![index].petId) {
        if (updateAppointmentRequest!.petIds![index].services!
            .containsKey(serviceId)) {
          updateAppointmentRequest!.petIds![index].services!.remove(serviceId);
        } else {
          updateAppointmentRequest!.petIds![index].services![serviceId] =
              service;
        }

        notifyListeners();
      }
    }
    dartDev.log("updateAppointmentRequest:");
    dartDev.log(jsonEncode(updateAppointmentRequest!.toJson()));
  }

  double calculateTotalForUpdateAppointmentRequest() {
    double totalPrice = 0;
    for (int i = 0; i < updateAppointmentRequest!.petIds!.length; i++) {
      updateAppointmentRequest!.petIds![i].services!.forEach((key, service) {
        totalPrice += service.price!;
      });
    }
    return totalPrice;
  }

  void selectPet(int newPetId) {
    selectedPetId = newPetId;
    notifyListeners();
  }
}
