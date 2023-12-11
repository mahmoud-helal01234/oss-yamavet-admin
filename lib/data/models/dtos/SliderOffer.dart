class SliderOffer {
  int? id;
  String? imgPath;
  String? link;

  SliderOffer({this.id, this.imgPath, this.link});

  SliderOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgPath = json['img_path'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img_path'] = this.imgPath;
    data['link'] = this.link;
    return data;
  }
}