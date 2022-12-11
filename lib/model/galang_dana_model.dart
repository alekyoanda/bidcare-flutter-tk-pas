// To parse this JSON data, do
//
//     final galangDana = galangDanaFromJson(jsonString);

import 'dart:convert';

List<GalangDana> galangDanaFromJson(String str) => List<GalangDana>.from(json.decode(str).map((x) => GalangDana.fromJson(x)));

String galangDanaToJson(List<GalangDana> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalangDana {
    GalangDana({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory GalangDana.fromJson(Map<String, dynamic> json) => GalangDana(
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
        required this.akunBank,
        required this.tujuan,
        required this.judul,
        required this.deskripsi,
        required this.terkumpul,
        required this.target,
        required this.gambar,
        required this.tanggalPembuatan,
        required this.tanggalBerakhir,
        required this.statusKeaktifan,
    });

    int user;
    int akunBank;
    String tujuan;
    String judul;
    String deskripsi;
    int terkumpul;
    int target;
    String gambar;
    DateTime tanggalPembuatan;
    DateTime tanggalBerakhir;
    bool statusKeaktifan;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        akunBank: json["akun_bank"],
        tujuan: json["tujuan"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        terkumpul: json["terkumpul"],
        target: json["target"],
        gambar: json["gambar"],
        tanggalPembuatan: DateTime.parse(json["tanggal_pembuatan"]),
        tanggalBerakhir: DateTime.parse(json["tanggal_berakhir"]),
        statusKeaktifan: json["status_keaktifan"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "akun_bank": akunBank,
        "tujuan": tujuan,
        "judul": judul,
        "deskripsi": deskripsi,
        "terkumpul": terkumpul,
        "target": target,
        "gambar": gambar,
        "tanggal_pembuatan": "${tanggalPembuatan.year.toString().padLeft(4, '0')}-${tanggalPembuatan.month.toString().padLeft(2, '0')}-${tanggalPembuatan.day.toString().padLeft(2, '0')}",
        "tanggal_berakhir": "${tanggalBerakhir.year.toString().padLeft(4, '0')}-${tanggalBerakhir.month.toString().padLeft(2, '0')}-${tanggalBerakhir.day.toString().padLeft(2, '0')}",
        "status_keaktifan": statusKeaktifan,
    };
}
