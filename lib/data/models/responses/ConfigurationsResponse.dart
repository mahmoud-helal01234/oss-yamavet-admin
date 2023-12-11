class ConfigurationsResponse {
  bool? status;
  Configurations? data;
  String? message;

  ConfigurationsResponse({this.status, this.data, this.message});

  ConfigurationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Configurations.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Configurations {
  int? id;
  int? petsNumber;
  String? whatsappNumber;
  int? emergancyPrice;
  int? ordinaryPrice;
  int? maxPrice;
  String? imgPath;

  Configurations(
      {this.id,
        this.petsNumber,
        this.whatsappNumber,
        this.emergancyPrice,
        this.ordinaryPrice,
        this.maxPrice,
        this.imgPath});

  Configurations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petsNumber = json['pets_number'];
    whatsappNumber = json['whatsapp_number'];
    emergancyPrice = json['emergancy_price'];
    ordinaryPrice = json['ordinary_price'];
    maxPrice = json['max_price'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pets_number'] = this.petsNumber;
    data['whatsapp_number'] = this.whatsappNumber;
    data['emergancy_price'] = this.emergancyPrice;
    data['ordinary_price'] = this.ordinaryPrice;
    data['max_price'] = this.maxPrice;
    data['img_path'] = this.imgPath;
    return data;
  }
}
