import 'package:bidcare/model/faq/faq.dart';
import 'package:bidcare/model/faq/pertanyaan.dart';
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

void buatPertanyaan(request, pertanyaan, kategori) async {
  try {
    await request.post(
        'https://bidcare.up.railway.app/customer_service/nanya-flutter/',
        {"teks_pertanyaan":pertanyaan, "kategori":kategori});
  } catch(e) {
      print(e);
  }
}

void buatFaq(request, pertanyaan, jawaban, pk) async {
  try {
    await request.post(
      'https://bidcare.up.railway.app/customer_service/jawab-flutter/${pk}',
      {"pertanyaan":pertanyaan, "jawaban":jawaban});
  } catch(e) {
      print(e);
  }
  
}

// void deletePertanyaan(request, pk) async {
//   await request.delete(
//       'https://bidcare.up.railway.app/customer_service/delete-flutter/${pk}');
// }

Future<List<Pertanyaan>> deletePertanyaan(pk) async {
  try {
    var url = Uri.parse('https://bidcare.up.railway.app/customer_service/delete-flutter/${pk}');
    var response = await http.delete(
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
  } catch(e){
    print(e);
    List<Pertanyaan> listPertanyaan = [];
    return listPertanyaan;
  }
    
}