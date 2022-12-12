import 'dart:convert';

List<Galang> toDoFromJson(String str) =>
    List<Galang>.from(json.decode(str).map((x) => Galang.fromJson(x)));

String toDoToJson(List<Galang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Galang {
  int pk;
  int user;
  int akunBank;
  String tujuan;
  String judul;
  String deskripsi;
  int terkumpul;
  int target;
  String gambar;
  DateTime tanggal_pembuatan;
  DateTime tanggal_berakhir;
  bool status_keaktifan;

  Galang({
    required this.pk,
    required this.user,
    required this.akunBank,
    required this.tujuan,
    required this.judul,
    required this.deskripsi,
    required this.terkumpul,
    required this.target,
    required this.gambar,
    required this.tanggal_pembuatan,
    required this.tanggal_berakhir,
    required this.status_keaktifan,
  });

  factory Galang.fromJson(Map<String, dynamic> json) => Galang(
        pk: json["pk"],
        user: json["fields"]["user"],
        akunBank: json["fields"]["akun_bank"],
        tujuan: json["fields"]["tujuan"],
        judul: json["fields"]["judul"],
        deskripsi: json["fields"]["deskripsi"],
        terkumpul: json["fields"]["terkumpul"],
        target: json["fields"]["target"],
        gambar: json["fields"]["gambar"],
        tanggal_pembuatan: DateTime.parse(json["fields"]["tanggal_pembuatan"]),
        tanggal_berakhir: DateTime.parse(json["fields"]["tanggal_berakhir"]),
        status_keaktifan: json["fields"]["status_keaktifan"],
      );

  Map<String, dynamic> toJson() => {
        "pk" : pk,
        "user": user,
        "akun_bank": akunBank,
        "tujuan": tujuan,
        "judul": judul,
        "deskripsi": deskripsi,
        "terkumpul": terkumpul,
        "target": target,
        "gambar": gambar,
        "tanggal_pembuatan": tanggal_pembuatan,
        "tanggal_berakhir": tanggal_berakhir,
        "status_keaktifan": status_keaktifan,
      };
}
