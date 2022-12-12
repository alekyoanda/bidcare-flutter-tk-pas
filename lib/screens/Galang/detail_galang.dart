import 'package:bidcare/widgets/card_lelang_builder,.dart';
import 'package:flutter/material.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:bidcare/screens/Galang/http_galang.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bidcare/screens/lelang/lelang_rincian.dart';

class MyDetailGalangPage extends StatefulWidget {
  final int pk;
  final int user;
  final String tujuan;
  final String judul;
  final String deskripsi;
  final int terkumpul;
  final int target;
  final DateTime tanggal_pembuatan;
  final DateTime tanggal_berakhir;
  final bool status_keaktifan;

  const MyDetailGalangPage({
    Key? key,
    required this.pk,
    required this.user,
    required this.tujuan,
    required this.judul,
    required this.deskripsi,
    required this.terkumpul,
    required this.target,
    required this.tanggal_pembuatan,
    required this.tanggal_berakhir,
    required this.status_keaktifan,
  }) : super(key: key);

  @override
  State<MyDetailGalangPage> createState() => _MyDetailGalangState();
}

class _MyDetailGalangState extends State<MyDetailGalangPage> {
  final formKey = GlobalKey<FormState>();
  String komentar = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Detail Galang Dana",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            backgroundColor: MyColor.darkGreen,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(color: Colors.white, Icons.arrow_back_ios),
            )),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: ListView(children: [
          // Judul
          Container(
              margin: const EdgeInsets.only(top: 35),
              child: Text(
                widget.judul,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )),

          // Tujuan
          Container(
              margin: const EdgeInsets.only(top: 3),
              child: Text(
                "#${widget.tujuan}ButuhBantuan",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    backgroundColor: Color.fromARGB(255, 255, 165, 0)),
              )),

          // Detail User
          FutureBuilder(
            future: fetchAkunGalang(widget.user),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Text(
                  "",
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Center(
                                child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.person,
                                        color: MyColor.darkGreen,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                        '${snapshot.data![index].first_name} ${snapshot.data![index].last_name}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ))
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      child: const Icon(
                                        Icons.email,
                                        color: MyColor.darkGreen,
                                        size: 20,
                                      ),
                                    ),
                                    Text('${snapshot.data![index].email}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ))
                                  ]),
                            ])),
                          ),
                        ));
              }
            },
          ),

          // Detail Uang
          Container(
              margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Row(children: [
                Text("Rp ${widget.terkumpul}",
                    style: const TextStyle(
                      color: MyColor.darkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                Text(" dari Rp ${widget.target}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ))
              ])),
          Container(
            margin: const EdgeInsets.only(top: 2, left: 25, right: 25),
            child: LinearProgressIndicator(
              backgroundColor: MyColor.lightGreen2,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColor.darkGreen),
              value: widget.terkumpul / widget.target,
              minHeight: 8,
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Deskripsi
          Container(
              margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Text(
                widget.deskripsi,
                style: const TextStyle(
                  fontSize: 16,
                ),
              )),

          const SizedBox(
            height: 20.0,
          ),

          // Detail Tanggal
          Container(
              color: MyColor.whiteGreen,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tanggal Pembuatan
                  Column(children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: MyColor.darkGreen,
                        size: 60.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 3,
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        "Tanggal Pembuatan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${widget.tanggal_pembuatan.day} - ${widget.tanggal_pembuatan.month} - ${widget.tanggal_pembuatan.year}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),

                  // Tanggal Berakhir
                  Column(children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 40, left: 15, right: 15),
                      child: const Icon(
                        Icons.hourglass_bottom,
                        color: MyColor.darkGreen,
                        size: 60.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 3,
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        "Tanggal Berakhir",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${widget.tanggal_berakhir.day} - ${widget.tanggal_berakhir.month} - ${widget.tanggal_berakhir.year}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ],
              )),

          // Lelang Dituju
          Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 15),
              color: const Color.fromARGB(255, 78, 17, 31),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: const Text(
                    "DAFTAR LELANG PENYUMBANG",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                FutureBuilder(
                    future: fetchLelangGalang(widget.pk),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Text(
                          "",
                        );
                      } else {
                        if (snapshot.data!.length == 0) {
                          return Column(children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "Galang Dana ini belum ada penyumbang:(",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]);
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (_, index) =>
                                  cardLelangBuilder(context, snapshot, index));
                        }
                      }
                    }),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // TextButton(
                //   onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => MyDetailGalangPage()
                //           )
                //         );
                // },
                //   child: const Text(
                //     'Buat Lelang untuk Galang Dana ini!',
                //     style: TextStyle(
                //       color: MyColor.lightGreen1,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
              ])),

          // Komentar
          Container(
              margin: const EdgeInsets.only(top: 25, bottom: 10),
              child: const Text(
                "Kolom Komentar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontStyle: FontStyle.italic),
              )),

          // Form Komentar
          Form(
            key: formKey,
            child: Container(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Tambahkan komentar...",
                          hintStyle:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                width: 2.0, color: MyColor.darkGreen),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                width: 2.0, color: MyColor.lightGreen1),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            komentar = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            komentar = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Komentar tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            tambahKomentar(
                                request, widget.pk.toString(), komentar);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 15,
                                  child: ListView(
                                    padding: const EdgeInsets.only(
                                        top: 40, bottom: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      const Center(
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 30.0,
                                          child: CircularProgressIndicator(
                                            value: null,
                                            strokeWidth: 4.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      const Center(
                                          child: Text(
                                              'Komentar sedang ditambahkan...')),
                                      const SizedBox(height: 20),
                                      TextButton(
                                        child: const Text(
                                            'Kembali ke Daftar Galang'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                            formKey.currentState!.reset();
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10.0)),
                          backgroundColor:
                              MaterialStateProperty.all(MyColor.lightGreen3),
                        ),
                        child: const Text(
                          "Comment",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          // Daftar Komentar
          FutureBuilder(
            future: fetchKomenGalang(widget.pk),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Text(
                  "",
                );
              } else {
                return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => InkWell(
                          child: Expanded(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                padding: const EdgeInsets.all(15.0),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2.0, color: MyColor.darkGreen),
                                    )),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: Image.asset(
                                          'assets/imageGalang/profile.png',
                                          height: 21,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].username,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      snapshot.data![index].komentar,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Text(
                                      "${snapshot.data![index].tanggal_komentar.day} - ${snapshot.data![index].tanggal_komentar.month} - ${snapshot.data![index].tanggal_komentar.year}",
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ])),
                          ),
                        ));
              }
            },
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Detail Rekening Tujuan
          FutureBuilder(
            future: fetchBankGalang(widget.pk),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Text(
                  "",
                );
              } else {
                return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => InkWell(
                          child: Expanded(
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding: const EdgeInsets.only(
                                    top: 35, left: 35, right: 35, bottom: 35),
                                decoration: const BoxDecoration(
                                    color: MyColor.darkGreen3,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2.0, color: MyColor.darkGreen),
                                    )),
                                child: Column(children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(top: 2),
                                    child: const Text(
                                      "Anda masih ingin membantu, bisa langsung ke ",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: const Text(
                                      "Rekening Tujuan",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Nama Pemilik:",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          snapshot.data![index].nama_pemilik,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Bank:",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          snapshot.data![index].nama_bank,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "No Rekening:",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          snapshot.data![index].no_rekening,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                ])),
                          ),
                        ));
              }
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
        ])));
  }
}
