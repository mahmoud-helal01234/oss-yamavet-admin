import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:yama_vet_admin/data/models/requests/AddSliderOfferRequest.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';

import '../data/models/dtos/SliderOffer.dart';
import '../data/models/requests/UpdateServiceRequest.dart';
import '../data/models/requests/UpdateSliderOfferRequest.dart';
import '../data/models/responses/SliderOffersResponse.dart';
import '../data/services/ApiService.dart';

class SliderOffersProvider extends ChangeNotifier {
  List<SliderOffer> sliderOffers = [];

  bool isAddingFormOpened = false;

  void toggleIsAddingFormOpened() {
    isAddingFormOpened = !isAddingFormOpened;
    notifyListeners();
  }

  void replace(List<SliderOffer> newSliderOffers) {
    sliderOffers = newSliderOffers;
    notifyListeners();
  }

  Future<void> get(BuildContext? context) async {
    SliderOffersResponse sliderOffersResponse = SliderOffersResponse.fromJson(
        await ApiService().get("slider_offer",
            context: context, componentName: "SliderOffer"));
    sliderOffers = sliderOffersResponse.sliderOffers!;
    notifyListeners();
  }

  Future<void> create(
      BuildContext context, AddSliderOfferRequest addSliderOfferRequest) async {
    await ApiService().postWithFiles("slider_offer",
        addSliderOfferRequest.toJson(), addSliderOfferRequest.files(),
        context: context, componentName: "SliderOffer");
    isAddingFormOpened = false;
    notifyListeners();
    get(null);
  }

  Future<void> delete(BuildContext context, int sliderOfferIndex) async {
    await ApiService().delete(
        "slider_offer", sliderOffers[sliderOfferIndex].id!,
        context: context, componentName: "SliderOffer");
    Navigator.pop(context);
    sliderOffers.removeAt(sliderOfferIndex);
    notifyListeners();
  }

  Future update(BuildContext context,
      UpdateSliderOfferRequest updateSliderOfferRequest) async {
    await ApiService().postWithFiles("slider_offer/update",
        updateSliderOfferRequest.toJson(), updateSliderOfferRequest.files(),
        context: context,
        componentName: "SliderOffer",
        operationName: "Updated");

    get(null);
  }
}
