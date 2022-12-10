import 'package:bidcare/model/barang_lelang_model.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllBarangLelang with ChangeNotifier {
  List<BarangLelang> _daftarBarangLelang = [];

  List<BarangLelang> get daftarBarangLelang {
    return [..._daftarBarangLelang];
  }

  Future<void> filterSearchBarangLelang(String key) async {
    await fetchBarangLelang();
    List<BarangLelang> out = [];
    for (BarangLelang b in _daftarBarangLelang) {
      if (b.fields.namaBarang.toLowerCase().contains(key.toLowerCase())) {
        print(b.fields.namaBarang);
        out.add(b);
      }
    }
    _daftarBarangLelang = out;
    notifyListeners();
  }

  Future<List<BarangLelang>> fetchBarangLelang({String? key}) async {
    var url = Uri.parse('https://bidcare.up.railway.app/lelang/json');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<BarangLelang> temp = [];

    for (var d in data) {
      if (d != null) {
        temp.add(BarangLelang.fromJson(d));
      }
    }
    _daftarBarangLelang = temp;

    temp = [];
    if (key != null) {
      for (BarangLelang b in _daftarBarangLelang) {
        if (b.fields.namaBarang.toLowerCase().contains(key.toLowerCase())) {
          temp.add(b);
        }
      }
      _daftarBarangLelang = temp;
    }

    return _daftarBarangLelang;
  }

  void barangLelangOnRefresh() {
    notifyListeners();
  }

  void barangLelangOnSearch() {
    notifyListeners();
  }
}
