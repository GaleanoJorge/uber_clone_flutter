// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Driver clientFromJson(String str) => Driver.fromJson(json.decode(str));

String clientToJson(Driver data) => json.encode(data.toJson());

class Driver {
  String id;
  String? name;
  String email;
  String plate;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.plate,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        plate: json["plate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "plate": plate,
      };
}
