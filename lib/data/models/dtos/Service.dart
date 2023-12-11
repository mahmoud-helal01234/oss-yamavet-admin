
class Service {
  int? id;
  String? nameAr;
  String? nameEn;
  int? price;
  int? categoryId;

  Service({this.id, this.nameAr, this.nameEn, this.price, this.categoryId});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['price'] = price;
    data['category_id'] = categoryId;
    return data;
  }
}



