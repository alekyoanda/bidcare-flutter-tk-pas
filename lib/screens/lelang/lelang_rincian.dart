import 'package:bidcare/screens/Galang/detail_galang.dart';
import 'package:bidcare/model/lelang/rincian_barang_lelang_models.dart';
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
  bool isRefresh = false;
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
        title: const Text("Rincian Lelang"),
      ),
      body: FutureBuilder(
        future: futureRincianBarangLelang,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: [
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
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
                  height: 0,
                  thickness: .8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
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
                                          ? "oleh " +
                                              snapshot.data!.userBidTertinggi
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
                                          color: (snapshot.data!.barangLelang
                                                  .fields.statusKeaktifan)
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
                            (snapshot.data!.barangLelang.fields.statusKeaktifan)
                                ? Center(
                                    child: MyElevatedButton(
                                        backgroundColor: MyColor.green1,
                                        text: const Text("Bid Sekarang"),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: ChangeNotifierProvider<
                                                      BidBarangLelang>(
                                                    create: (context) =>
                                                        BidBarangLelang(),
                                                    child: Consumer<
                                                        BidBarangLelang>(
                                                      builder: (context, value,
                                                              child) =>
                                                          Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              "Jumlah Bid",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            TextFormField(
                                                              onChanged: (v) {
                                                                value.changeBid(
                                                                    v);
                                                              },
                                                              validator:
                                                                  (String?
                                                                      value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Tidak boleh kosong!';
                                                                } else if (int
                                                                        .parse(
                                                                            value) <=
                                                                    snapshot
                                                                        .data!
                                                                        .barangLelang
                                                                        .fields
                                                                        .bidTertinggi) {
                                                                  return "Bid harus lebih besar dari Rp${snapshot.data!.barangLelang.fields.bidTertinggi}";
                                                                }
                                                                return null;
                                                              },
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      prefixText:
                                                                          "Rp"),
                                                            ),
                                                            Text(
                                                              "Minimal bid sebesar Rp${NumberFormat('#,###').format(snapshot.data!.barangLelang.fields.bidTertinggi).toString()}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            MyElevatedButton(
                                                                backgroundColor: (value.curBid >
                                                                        snapshot
                                                                            .data!
                                                                            .barangLelang
                                                                            .fields
                                                                            .bidTertinggi)
                                                                    ? MyColor
                                                                        .green1
                                                                    : Colors
                                                                        .grey,
                                                                text:
                                                                    const Text(
                                                                        "Bid"),
                                                                onPressed:
                                                                    () async {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    print(
                                                                        "${value.curBid} dalem post");
                                                                    String url =
                                                                        'https://bidcare.up.railway.app/lelang/bid_barang_lelang/${snapshot.data!.barangLelang.pk}';

                                                                    await request
                                                                        .post(
                                                                      url,
                                                                      {
                                                                        'banyak_bid': value
                                                                            .curBid
                                                                            .toString(),
                                                                        'tes':
                                                                            'pls'
                                                                      },
                                                                    ).then(
                                                                      (value) {
                                                                        setState(
                                                                            () {
                                                                          isRefresh =
                                                                              true;
                                                                        });
                                                                      },
                                                                    );
                                                                    Navigator.pop(
                                                                        context);
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
                                  )
                                : const SizedBox(
                                    height: 8,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Informasi Lelang",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Lelang dibuat oleh:"),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: MyColor.darkGreen,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              snapshot.data!.userPelelang,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.darkGreen,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text("Harga Awal"),
                                          Text(
                                            "Rp${NumberFormat('#,###').format(snapshot.data!.barangLelang.fields.startingBid).toString()}",
                                            style: const TextStyle(
                                                color: MyColor.darkGreen,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ])
                                  ]),
                              const Divider(
                                thickness: .6,
                                height: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Deskripsi Barang Lelang",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    snapshot
                                        .data!.barangLelang.fields.deskripsi,
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Informasi Galang Dana Tujuan",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                snapshot.data!.galangDanaTujuan.fields.judul,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Digalang oleh:"),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: MyColor.darkGreen,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              snapshot.data!.userGalangDana,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: MyColor.darkGreen,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text("Target Galang Dana"),
                                          Text(
                                            "Rp${NumberFormat('#,###').format(snapshot.data!.galangDanaTujuan.fields.target).toString()}",
                                            style: const TextStyle(
                                                color: MyColor.darkGreen,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ])
                                  ]),
                              const Divider(
                                thickness: .6,
                                height: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.all(12),
                                    color: const Color.fromARGB(
                                        255, 211, 253, 245),
                                    child: const Text(
                                      "Disclaimer: 70% bid tertinggi dari lelang ini akan disumbangkan kepada galang dana tujuan",
                                      style: TextStyle(
                                          color: MyColor.darkGreen,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Lelang ini menyumbang "),
                                        TextSpan(
                                            text:
                                                "${70 * snapshot.data!.barangLelang.fields.bidTertinggi / snapshot.data!.galangDanaTujuan.fields.target}%",
                                            style: const TextStyle(
                                                color: MyColor.green1,
                                                fontWeight: FontWeight.w600)),
                                        const TextSpan(
                                            text: " dari target galang dana")
                                      ],
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  LinearProgressIndicator(
                                    minHeight: 10,
                                    value: 0.7 *
                                        snapshot.data!.barangLelang.fields
                                            .bidTertinggi /
                                        snapshot.data!.galangDanaTujuan.fields
                                            .target,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Rp${NumberFormat('#,###').format(0.7 * snapshot.data!.barangLelang.fields.bidTertinggi)} / ${NumberFormat('#,###').format(snapshot.data!.galangDanaTujuan.fields.target)}",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const Divider(
                                    thickness: .6,
                                    height: 24,
                                  ),
                                  Center(
                                    child: MyElevatedButton(
                                        text: const Text(
                                            "Lihat Detail Galang Dana"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyDetailGalangPage(
                                                        pk: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .pk,
                                                        tujuan: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .tujuan,
                                                        judul: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .judul,
                                                        deskripsi: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .deskripsi,
                                                        terkumpul: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .terkumpul,
                                                        target: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .target,
                                                        tanggal_pembuatan: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .tanggalPembuatan,
                                                        tanggal_berakhir: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .tanggalBerakhir,
                                                        status_keaktifan: snapshot
                                                            .data!
                                                            .galangDanaTujuan
                                                            .fields
                                                            .statusKeaktifan,
                                                      )));
                                        }),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              "Komentar",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.semuaKomentar.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.semuaKomentar.length == 0) {
                                  return const Text("Tidak ada komentar");
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Anonymous",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700]),
                                              ),
                                              Text(
                                                '${(-1 * (DateTime.parse(snapshot.data!.semuaKomentar[index]["fields"]["waktu_ditambahkan"]).difference(DateTime.now()).inHours)).toString()} jam yang lalu',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(snapshot.data!.semuaKomentar[index]
                                          ["fields"]["teks"]),
                                      const Divider(
                                        height: 32,
                                        thickness: .6,
                                      )
                                    ],
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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

  return RincianBarangLelang.fromJson(data);
}
