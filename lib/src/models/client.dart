// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  String id;
  String? name;
  String email;

  Client({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
