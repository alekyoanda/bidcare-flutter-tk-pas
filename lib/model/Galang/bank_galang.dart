import 'dart:convert';

List<BankGalang> toDoFromJson(String str) =>
    List<BankGalang>.from(json.decode(str).map((x) => BankGalang.fromJson(x)));

String toDoToJson(List<BankGalang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankGalang {
  int pk;
  String nama_pemilik;
  String nama_bank;
  String no_rekening;

  BankGalang({
    required this.pk,
    required this.nama_pemilik,
    required this.nama_bank,
   required this.no_rekening,
  });

  factory BankGalang.fromJson(Map<String, dynamic> json) => BankGalang(
        pk: json["pk"],
        nama_pemilik: json["fields"]["nama_pemilik"],
        nama_bank: json["fields"]["nama_bank"],
        no_rekening: json["fields"]["no_rekening"],
      );

  Map<String, dynamic> toJson() => {
        "pk" : pk,
        "nama_pemilik": nama_pemilik,
        "nama_bank": nama_bank,
        "no_rekening": no_rekening,
      };
}
