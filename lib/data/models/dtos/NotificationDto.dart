
class NotificationDto {
  int? id;
  String? nameAr;
  String? nameEn;

  NotificationDto({this.id, this.nameAr, this.nameEn});

  NotificationDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;

    return data;
  }
}
