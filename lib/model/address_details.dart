import 'city.dart';

class AddressDetails {
  late int id;
  late String name;
  late String info;
  late String contactNumber;
  late int cityId;
  double? lat;
  double? lang;
  City? city;

  AddressDetails();

  AddressDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    contactNumber = json['contact_number'];
    lat = json['lat'];
    lang = json['lang'];
    cityId = json['city_id'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }
}
