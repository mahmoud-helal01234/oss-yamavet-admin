class ClientLocation {
  double? longitude;
  double? latitude;
  String? description;

  ClientLocation({this.longitude, this.latitude, this.description});

  ClientLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['description'] = description;
    return data;
  }
}
