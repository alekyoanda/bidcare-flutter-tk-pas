// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

List<Faq> faqFromJson(String str) => List<Faq>.from(json.decode(str).map((x) => Faq.fromJson(x)));

String faqToJson(List<Faq> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faq {
    Faq({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Faq.fromJson(Map<String, dynamic> json) => Faq(
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
        required this.pertanyaan,
        required this.jawaban,
    });

    List<String> pertanyaan;
    String jawaban;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        pertanyaan: List<String>.from(json["pertanyaan"].map((x) => x)),
        jawaban: json["jawaban"],
    );

    Map<String, dynamic> toJson() => {
        "pertanyaan": List<dynamic>.from(pertanyaan.map((x) => x)),
        "jawaban": jawaban,
    };
}
