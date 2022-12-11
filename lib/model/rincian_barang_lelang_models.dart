// To parse this JSON data, do
//
//     final rincianBarangLelang = rincianBarangLelangFromJson(jsonString);

import 'dart:convert';

import 'package:bidcare/model/galang_dana_model.dart';
import 'package:bidcare/model/komentar_lelang.dart';

import 'barang_lelang_model.dart';

RincianBarangLelang rincianBarangLelangFromJson(String str) =>
    RincianBarangLelang.fromJson(json.decode(str));

String rincianBarangLelangToJson(RincianBarangLelang data) =>
    json.encode(data.toJson());

class RincianBarangLelang {
  RincianBarangLelang({
    required this.barangLelang,
    required this.userPelelang,
    required this.galangDanaTujuan,
    required this.userGalangDana,
    required this.userBidTertinggi,
    required this.semuaKomentar,
  });

  BarangLelang barangLelang;
  String userPelelang;
  GalangDana galangDanaTujuan;
  String userGalangDana;
  String userBidTertinggi;
  List<dynamic> semuaKomentar;

  factory RincianBarangLelang.fromJson(Map<String, dynamic> json) {
    return RincianBarangLelang(
      barangLelang: BarangLelang.fromJson(json["barang_lelang"]),
      userPelelang: json["user_pelelang"],
      galangDanaTujuan: GalangDana.fromJson(json["galang_dana_tujuan"]),
      userGalangDana: json["user_galang_dana"],
      userBidTertinggi: json["user_bid_tertinggi"],
      semuaKomentar: (json["semua_komentar"].length != 0)
          ? List<dynamic>.from(json["semua_komentar"].map((x) => x))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "barang_lelang": barangLelang.toJson(),
        "user_pelelang": userPelelang,
        "galang_dana_tujuan": galangDanaTujuan.toJson(),
        "user_galang_dana": userGalangDana,
        "user_bid_tertinggi": userBidTertinggi,
        "semua_komentar":
            List<dynamic>.from(semuaKomentar.map((x) => x)),
      };
}
