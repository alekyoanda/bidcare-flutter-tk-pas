import 'package:bidcare/model/faq.dart';
import 'package:bidcare/model/pertanyaan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Faq>> fetchFAQ() async {
    var url = Uri.parse('https://bidcare.up.railway.app/customer_service/json/faq');
    var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object faq
    List<Faq> listFaq = [];
    for (var d in data) {
    if (d != null) {
        listFaq.add(Faq.fromJson(d));
    }
    }

    return listFaq;
}

Future<List<Pertanyaan>> fetchPertanyaan() async {
    var url = Uri.parse('https://bidcare.up.railway.app/customer_service/json/pertanyaan');
    var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object faq
    List<Pertanyaan> listPertanyaan = [];
    for (var d in data) {
    if (d != null) {
        listPertanyaan.add(Pertanyaan.fromJson(d));
    }
    }

    return listPertanyaan;
}

void join(request, pertanyaan, kategori) async {
  await request.post(
      'https://bidcare.up.railway.app/customer_service/nanya-flutter/',
      {"teks_pertanyaan":pertanyaan, "kategori":kategori});
}
