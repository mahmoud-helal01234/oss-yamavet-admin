class CategoriesResponse {
  bool? status;
  List<Category>? categories;
  Null? message;

  CategoriesResponse({this.status, this.categories, this.message});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    message = json['message'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   if (this.categories != null) {
  //     data['data'] = this.categories!.map((v) => v.toJson()).toList();
  //   }
  //   data['message'] = this.message;
  //   return data;
  // }
}

class Category {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  List<CategoryService>? services;

  Category({this.id, this.nameAr, this.nameEn, this.imgPath, this.services});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    if (json['services'] != null) {
      services = <CategoryService>[];
      json['services'].forEach((v) {
        services!.add(CategoryService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['img_path'] = imgPath;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryService {
  int? id;
  double? price;
  int? categoryId;
  String? nameAr;
  String? nameEn;

  CategoryService({this.id, this.price, this.categoryId, this.nameAr, this.nameEn});

  CategoryService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.parse(json['price'].toString()) ;
    categoryId = json['category_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['price'] = price;
    data['category_id'] = categoryId;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    return data;
  }
}
