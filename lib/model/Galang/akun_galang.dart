import 'dart:convert';

List<AkunGalang> toDoFromJson(String str) =>
    List<AkunGalang>.from(json.decode(str).map((x) => AkunGalang.fromJson(x)));

String toDoToJson(List<AkunGalang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AkunGalang {
  int pk;
  String username;
  String first_name;
  String last_name;
  String email;

  AkunGalang({
    required this.pk,
    required this.username,
    required this.first_name,
   required this.last_name,
   required this.email,
  });

  factory AkunGalang.fromJson(Map<String, dynamic> json) => AkunGalang(
        pk: json["pk"],
        username: json["fields"]["username"],
        first_name: json["fields"]["first_name"],
        last_name: json["fields"]["last_name"],
        email: json["fields"]["email"],
      );

  Map<String, dynamic> toJson() => {
        "pk" : pk,
        "username": username,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
      };
}
