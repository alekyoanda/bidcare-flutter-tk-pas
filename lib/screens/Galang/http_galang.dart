import 'package:http/http.dart' as http;
import 'package:bidcare/model/Galang/galang.dart';
import 'package:bidcare/model/Galang/komen_galang.dart';
import 'package:bidcare/model/lelang/barang_lelang_model.dart';
import 'package:bidcare/model/Galang/bank_galang.dart';
import 'dart:convert';

// Galang Dana

Future<List<Galang>> fetchGalang() async {
  var url = Uri.parse('https://bidcare.up.railway.app/resipien/json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Galang> listGalang = [];
  for (var d in data) {
    if (d != null) {
      listGalang.add(Galang.fromJson(d));
    }
  }

  return listGalang;
}

void buatGalang(request, tujuan, judul, deskripsi, target, tanggal_berakhir,
    nama_pemilik, nama_bank, no_rekening) async {
  try {
    await request.post('https://bidcare.up.railway.app/resipien/fbuatGalang/', {
      "tujuan": tujuan,
      "judul": judul,
      "deskripsi": deskripsi,
      "target": target,
      "tanggal_berakhir": tanggal_berakhir,
      "nama_pemilik": nama_pemilik,
      "nama_bank": nama_bank,
      "no_rekening": no_rekening
    });
  } catch (e) {
    print(e);
  }
}

// Komentar Galang Dana

Future<List<KomenGalang>> fetchKomenGalang(id) async {
  var url =
      Uri.parse("https://bidcare.up.railway.app/resipien/komentarjson/$id");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var komen = jsonDecode(utf8.decode(response.bodyBytes));

  List<KomenGalang> listKomenGalang = [];
  for (var d in komen) {
    if (d != null) {
      listKomenGalang.add(KomenGalang.fromJson(d));
    }
  }

  return listKomenGalang;
}

void tambahKomentar(request, id, komentar) async {
  try {
    await request
        .post('https://bidcare.up.railway.app/resipien/ftambahKomentar/$id', {
      "komentar": komentar,
    });
  } catch (e) {
    print(e);
  }
}

// Lelang untuk Galang Dana

Future<List<BarangLelang>> fetchLelangGalang(id) async {
  var url = Uri.parse("https://bidcare.up.railway.app/resipien/lelangjson/$id");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var lelang = jsonDecode(utf8.decode(response.bodyBytes));

  List<BarangLelang> listLelangGalang = [];
  for (var d in lelang) {
    if (d != null) {
      listLelangGalang.add(BarangLelang.fromJson(d));
    }
  }

  return listLelangGalang;
}

// Akun Bank

Future<List<BankGalang>> fetchBankGalang(id) async {
  var url =
      Uri.parse("https://bidcare.up.railway.app/resipien/bankjson/$id");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var akun = jsonDecode(utf8.decode(response.bodyBytes));

  List<BankGalang> listKomenGalang = [];
  for (var d in akun) {
    if (d != null) {
      listKomenGalang.add(BankGalang.fromJson(d));
    }
  }

  return listKomenGalang;
}

