// To parse this JSON data, do
//
//     final barangLelang = barangLelangFromJson(jsonString);

import 'dart:convert';

List<BarangLelang> barangLelangFromJson(String str) => List<BarangLelang>.from(json.decode(str).map((x) => BarangLelang.fromJson(x)));

String barangLelangToJson(List<BarangLelang> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BarangLelang {
    BarangLelang({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory BarangLelang.fromJson(Map<String, dynamic> json) => BarangLelang(
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
        required this.pelelang,
        required this.galangDanaTujuan,
        required this.namaBarang,
        required this.deskripsi,
        required this.gambar,
        required this.startingBid,
        required this.bidTertinggi,
        required this.tanggalMulai,
        required this.tanggalBerakhir,
        required this.statusKeaktifan,
        required this.kategoriBarang,
    });

    int pelelang;
    int galangDanaTujuan;
    String namaBarang;
    String deskripsi;
    String gambar;
    int startingBid;
    int bidTertinggi;
    DateTime tanggalMulai;
    DateTime tanggalBerakhir;
    bool statusKeaktifan;
    String kategoriBarang;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        pelelang: json["pelelang"],
        galangDanaTujuan: json["galang_dana_tujuan"],
        namaBarang: json["nama_barang"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        startingBid: json["starting_bid"],
        bidTertinggi: json["bid_tertinggi"],
        tanggalMulai: DateTime.parse(json["tanggal_mulai"]),
        tanggalBerakhir: DateTime.parse(json["tanggal_berakhir"]),
        statusKeaktifan: json["status_keaktifan"],
        kategoriBarang: json["kategori_barang"],
    );

    Map<String, dynamic> toJson() => {
        "pelelang": pelelang,
        "galang_dana_tujuan": galangDanaTujuan,
        "nama_barang": namaBarang,
        "deskripsi": deskripsi,
        "gambar": gambar,
        "starting_bid": startingBid,
        "bid_tertinggi": bidTertinggi,
        "tanggal_mulai": tanggalMulai.toIso8601String(),
        "tanggal_berakhir": tanggalBerakhir.toIso8601String(),
        "status_keaktifan": statusKeaktifan,
        "kategori_barang": kategoriBarang,
    };
}

