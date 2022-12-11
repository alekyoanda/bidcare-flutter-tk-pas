import 'dart:ffi';

import 'package:bidcare/model/rincian_barang_lelang_models.dart';
import 'package:bidcare/providers/bid_barang_lelang.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:bidcare/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyLelangRincianPage extends StatefulWidget {
  const MyLelangRincianPage({super.key, required this.lelang_id});

  final int lelang_id;

  @override
  State<MyLelangRincianPage> createState() =>
      _MyLelangRincianPageState(lelang_id);
}

class _MyLelangRincianPageState extends State<MyLelangRincianPage> {
  _MyLelangRincianPageState(this.lelang_id);

  final _formKey = GlobalKey<FormState>();

  late Future<RincianBarangLelang> futureRincianBarangLelang;
  final int lelang_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRincianBarangLelang = fetchBarangLelangById(lelang_id);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tes"),
      ),
      body: FutureBuilder(
        future: fetchBarangLelangById(lelang_id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: [
                const Center(child: CircularProgressIndicator()),
                Text(snapshot.connectionState.toString())
              ],
            );
          } else {
            return ListView(
              children: [
                Image.asset(
                  'images/${snapshot.data!.barangLelang.fields.gambar}',
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'images/lelang/product-image-placeholder.jpg',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 6,
                  thickness: .8,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.barangLelang.fields.namaBarang,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Bid tertinggi:"),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Rp${NumberFormat('#,###').format(snapshot.data!.barangLelang.fields.bidTertinggi).toString()}",
                                style: const TextStyle(
                                    color: MyColor.green1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                (snapshot.data!.userBidTertinggi != "")
                                    ? "oleh " + snapshot.data!.userBidTertinggi
                                    : "Harga Awal",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Sisa waktu:",
                              ),
                              Text(
                                (snapshot.data!.barangLelang.fields
                                        .statusKeaktifan)
                                    ? '${snapshot.data!.barangLelang.fields.tanggalBerakhir.difference(DateTime.now()).inDays.toString()} hari'
                                    : "Lelang selesai",
                                style: TextStyle(
                                    color: (snapshot.data!.barangLelang.fields
                                            .statusKeaktifan)
                                        ? Colors.grey[600]
                                        : Colors.red,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: MyElevatedButton(
                            backgroundColor: MyColor.green1,
                            text: const Text("Bid Sekarang"),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    height: 240,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ChangeNotifierProvider<
                                          BidBarangLelang>(
                                        create: (context) => BidBarangLelang(),
                                        child: Consumer<BidBarangLelang>(
                                          builder: (context, value, child) =>
                                              Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Jumlah Bid",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                TextFormField(
                                                  onChanged: (v) {
                                                    value.changeBid(v);
                                                  },
                                                  validator: (String? value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Tidak boleh kosong!';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      prefixText: "Rp"),
                                                ),
                                                Text(
                                                  "Minimal bid sebesar Rp${NumberFormat('#,###').format(snapshot.data!.barangLelang.fields.bidTertinggi).toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                MyElevatedButton(
                                                    backgroundColor:
                                                        MyColor.green1,
                                                    text: const Text("Bid"),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        print(
                                                            "${value.curBid} dalem post");
                                                        String url =
                                                            'https://bidcare.up.railway.app/lelang/bid_barang_lelang/${snapshot.data!.barangLelang.pk}';

                                                        await request.post(
                                                          url,
                                                          {
                                                            'banyak_bid': value
                                                                .curBid
                                                                .toString(),
                                                            'tes': 'pls'
                                                          },
                                                        );
                                                        print("Berhasil");
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: .7, color: Colors.grey),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: 500,
                        height: 400,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: 500,
                        height: 300,
                        color: Colors.blue,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: 500,
                        height: 200,
                        color: Colors.green,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

Future<RincianBarangLelang> fetchBarangLelangById(int id) async {
  var url = Uri.parse('https://bidcare.up.railway.app/lelang/json/$id');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  print(RincianBarangLelang.fromJson(data).semuaKomentar);

  return RincianBarangLelang.fromJson(data);
}
