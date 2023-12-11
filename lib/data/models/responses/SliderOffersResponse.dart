import '../dtos/SliderOffer.dart';

class SliderOffersResponse {
  bool? status;
  List<SliderOffer>? sliderOffers;
  String? message;

  SliderOffersResponse({this.status, this.sliderOffers, this.message});

  SliderOffersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sliderOffers = <SliderOffer>[];
      json['data'].forEach((v) {
        sliderOffers!.add(SliderOffer.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.sliderOffers != null) {
      data['data'] = this.sliderOffers!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}


