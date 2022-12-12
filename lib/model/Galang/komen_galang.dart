import 'dart:convert';

List<KomenGalang> toDoFromJson(String str) => List<KomenGalang>.from(json.decode(str).map((x) => KomenGalang.fromJson(x)));

String toDoToJson(List<KomenGalang> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KomenGalang {
  int user;
  String username;
  int objekGalang;
  String komentar;
  DateTime tanggal_komentar;

  KomenGalang({

    required this.user,
    required this.username,
    required this.objekGalang,
    required this.komentar,
    required this.tanggal_komentar,

    });

  factory KomenGalang.fromJson(Map<String, dynamic> json) => KomenGalang(
    user: json["fields"]["user"],
    username: json["fields"]["username"],
    objekGalang: json["fields"]["objek_galang"],
    komentar: json["fields"]["komentar"],
    tanggal_komentar: DateTime.parse(json["fields"]["tanggal_komentar"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "username": username,
    "objek_galang": objekGalang,
    "komentar": komentar,
    "tanggal_komentar": tanggal_komentar,
  };
}

