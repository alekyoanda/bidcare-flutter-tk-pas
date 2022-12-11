// To parse this JSON data, do
//
//     final komentarLelang = komentarLelangFromJson(jsonString);

import 'dart:convert';

List<KomentarLelang> komentarLelangFromJson(String str) => List<KomentarLelang>.from(json.decode(str).map((x) => KomentarLelang.fromJson(x)));

String komentarLelangToJson(List<KomentarLelang> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KomentarLelang {
    KomentarLelang({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory KomentarLelang.fromJson(Map<String, dynamic> json) => KomentarLelang(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.user,
        required this.barangLelang,
        required this.waktuDitambahkan,
        required this.teks,
    });

    int user;
    int barangLelang;
    DateTime waktuDitambahkan;
    String teks;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        barangLelang: json["barang_lelang"],
        waktuDitambahkan: DateTime.parse(json["waktu_ditambahkan"]),
        teks: json["teks"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "barang_lelang": barangLelang,
        "waktu_ditambahkan": waktuDitambahkan.toIso8601String(),
        "teks": teks,
    };
}
