// To parse this JSON data, do
//
//     final pertanyaan = pertanyaanFromJson(jsonString);

import 'dart:convert';

List<Pertanyaan> pertanyaanFromJson(String str) => List<Pertanyaan>.from(json.decode(str).map((x) => Pertanyaan.fromJson(x)));

String pertanyaanToJson(List<Pertanyaan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pertanyaan {
    Pertanyaan({
      required this.kategori,
      required this.teksPertanyaan,
      // required this.isAnswered,
      // required this.pk,
    });

    // int pk;
    String kategori;
    String teksPertanyaan;
    // bool isAnswered;

    factory Pertanyaan.fromJson(Map<String, dynamic> json) => Pertanyaan(
        // pk: json["pk"],
        kategori: json["fields"]["kategori"],
        teksPertanyaan: json["fields"]["teks_pertanyaan"],
        // isAnswered: json["fields"]["is_answered"],
    );

    Map<String, dynamic> toJson() => {
        // "pk": pk,
        "kategori": kategori,
        "teks_pertanyaan": teksPertanyaan,
        // "is_answered": isAnswered,
    };

    
}