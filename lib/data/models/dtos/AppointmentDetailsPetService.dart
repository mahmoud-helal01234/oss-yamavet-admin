class AppointmentDetailsPetService {
  int? id;
  String? nameAr;
  String? nameEn;
  int? price;
  int? categoryId;

  AppointmentDetailsPetService({this.id, this.nameAr, this.nameEn, this.price, this.categoryId});

  AppointmentDetailsPetService.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  nameAr = json['name_ar'];
  nameEn = json['name_en'];
  price = json['price'];
  categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name_ar'] = this.nameAr;
  data['name_en'] = this.nameEn;
  data['price'] = this.price;
  data['category_id'] = this.categoryId;
  return data;
  }
  }