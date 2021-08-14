class Address {
  late String name;
  late String info;
  late String contactNumber;
  late int cityId;
  late double? lat;
  late double? lang;
  late int id;

  Address();

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    info = json['info'];
    contactNumber = json['contact_number'];
    cityId = json['city_id'];
    lat = json['lat'];
    lang = json['lang'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['info'] = this.info;
    data['contact_number'] = this.contactNumber;
    data['city_id'] = this.cityId;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['id'] = this.id;
    return data;
  }
}