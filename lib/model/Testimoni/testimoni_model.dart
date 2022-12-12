// To parse this JSON data, do
//
//     final testimoniModel = testimoniModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

List<TestimoniModel> testimoniModelFromJson(String str) => List<TestimoniModel>.from(json.decode(str).map((x) => TestimoniModel.fromJson(x)));

String testimoniModelToJson(List<TestimoniModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestimoniModel {
    TestimoniModel({
      required this.pk,
      required this.fields,
    });

    int pk;
    Fields fields;

    factory TestimoniModel.fromJson(Map<String, dynamic> json) => TestimoniModel(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
      required this.user,
      required this.nama,
      required this.target,
      required this.pesan,
    });

    int user;
    String nama;
    String target;
    String pesan;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        nama: json["nama"],
        target: json["target"],
        pesan: json["pesan"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "nama": nama,
        "target": target,
        "pesan": pesan,
    };
}

Future<List<TestimoniModel>> fetchTestimoni() async {
  var url = Uri.parse('https://bidcare.up.railway.app/testimoni/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },    
  );
    
  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<TestimoniModel> listTestimoni = [];
      
  for (var d in data) {
    if (d != null) {
      listTestimoni.add(TestimoniModel.fromJson(d));
    }
  }
  
  return listTestimoni;
}

addTestimoni(BuildContext context,String nama, String target, String pesan) async{
  final request = context.read<CookieRequest>();
  var url = Uri.parse('https://bidcare.up.railway.app/testimoni/add-testimoni/');
  var response = await http.post(
    url,
    headers: request.headers,
    body: {
      "nama" : nama,
      "target" : target,
      "pesan" : pesan,
    });
  print(response.statusCode.toString());
}