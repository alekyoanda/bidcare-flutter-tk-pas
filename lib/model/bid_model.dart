// To parse this JSON data, do
//
//     final bid = bidFromJson(jsonString);

import 'dart:convert';

List<Bid> bidFromJson(String str) => List<Bid>.from(json.decode(str).map((x) => Bid.fromJson(x)));

String bidToJson(List<Bid> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bid {
    Bid({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Bid.fromJson(Map<String, dynamic> json) => Bid(
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
        required this.user,
        required this.barangLelang,
        required this.banyakBid,
    });

    int user;
    int barangLelang;
    int banyakBid;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        barangLelang: json["barang_lelang"],
        banyakBid: json["banyak_bid"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "barang_lelang": barangLelang,
        "banyak_bid": banyakBid,
    };
}
