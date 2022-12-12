import 'package:bidcare/screens/Galang/http_galang.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyBuatGalangPage extends StatefulWidget {
  const MyBuatGalangPage({super.key});

  @override
  State<MyBuatGalangPage> createState() => _MyBuatGalangState();
}

class _MyBuatGalangState extends State<MyBuatGalangPage> {
  final formKey = GlobalKey<FormState>();

  // Galang Dana
  List<String> listTujuan = [
    "Pribadi",
    "Keluarga",
    "Institusi",
    "Teman",
    "Lainnya"
  ];
  String tujuan = "";
  String judul = "";
  String deskripsi = "";
  int target = 0;
  String tanggal_berakhir = "";

  // Rekening Tujuan
  List<String> listBank = ["MANDIRI", "BNI", "BCA", "BRI", "OTHER"];
  String nama_pemilik = "";
  String nama_bank = "";
  String no_rekening = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
          appBar: AppBar(
                title: const Text(
                  "Buat Galang Dana",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyColor.darkGreen),),
                backgroundColor: MyColor.lightGreen1,
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    color: MyColor.darkGreen,
                    Icons.arrow_back_ios), 
                  //replace with our own icon data.
            )
          ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  MyColor.lightGreen1,
                  MyColor.lightGreen2,
                  MyColor.green1
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
            // ignore: sort_child_properties_last
            child: SafeArea(
                child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      // Form Galang Dana
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.whiteGreen,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20, bottom: 20),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: const Text("Detail Galang Dana",
                                  style: TextStyle(
                                    color: MyColor.darkGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),

                            const Divider(
                              color: Colors.black,
                            ),

                            // Tujuan Keperluan
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: null,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  tujuan == "" ? 'Tujuan Keperluan' : tujuan,
                                  style: const TextStyle(
                                      fontSize: 15, color: MyColor.darkGreen),
                                ),
                                items: listTujuan.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    tujuan = newValue!;
                                  });
                                },
                              ),
                            ),

                            // Judul
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Judul",
                                  hintStyle: const TextStyle(
                                      fontSize: 15, color: MyColor.darkGreen),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: MyColor.darkGreen),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: MyColor.lightGreen1),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    judul = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    judul = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Judul tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            // Deskripsi
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Deskripsi",
                                  hintStyle: const TextStyle(
                                      fontSize: 15, color: MyColor.darkGreen),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: MyColor.darkGreen),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: MyColor.lightGreen1),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    deskripsi = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    deskripsi = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Deskripsi tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            // Target
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Target",
                                  hintStyle: const TextStyle(
                                      fontSize: 15, color: MyColor.darkGreen),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: MyColor.darkGreen),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: MyColor.lightGreen1),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value == null || value.isEmpty) {
                                      target = 0;
                                    } else {
                                      target = BigInt.parse(value).toInt();
                                    }
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    if (value == null || value.isEmpty) {
                                      target = 0;
                                    } else {
                                      target = BigInt.parse(value).toInt();
                                    }
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "0") {
                                    return 'Target tidak valid!';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Tanggal Berakhir
                            const Text(
                              "Tanggal Berakhir",
                              style: TextStyle(fontSize: 15, color: MyColor.darkGreen),
                            ),
                            Padding(
                               padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "YYYY-MM-DD",
                                  hintStyle: const TextStyle(
                                      fontSize: 15, color: MyColor.darkGreen),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: MyColor.darkGreen),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: MyColor.lightGreen1),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    tanggal_berakhir = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    tanggal_berakhir = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tanggal tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ]
                        )
                      ),

                      const SizedBox(height: 20),

                      // Form Rekening Tujuan
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.whiteGreen,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20, bottom: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 15),
                                child: const Text(
                                  "Detail Rekening Tujuan",
                                  style: TextStyle(
                                    color: MyColor.darkGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const Divider(
                                color: Colors.black,
                              ),

                              const SizedBox(height: 10),

                              // Nama Bank
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  value: null,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: Text(
                                    nama_bank == "" ? 'Nama Bank' : nama_bank,
                                    style: const TextStyle(
                                        fontSize: 15, color: MyColor.darkGreen),
                                  ),
                                  items: listBank.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      nama_bank = newValue!;
                                    });
                                  },
                                ),
                              ),

                              // No Rekening
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "No Rekening",
                                    hintStyle: const TextStyle(
                                        fontSize: 15, color: MyColor.darkGreen),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0, color: MyColor.darkGreen),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color: MyColor.lightGreen1),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String? value) {
                                    setState(() {
                                      no_rekening = value!;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      no_rekening = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'No Rekening tidak valid!';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              // Nama Pemilik
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Nama Pemilik",
                                    hintStyle: const TextStyle(
                                        fontSize: 15, color: MyColor.darkGreen),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 2.0, color: MyColor.darkGreen),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: MyColor.lightGreen1),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      nama_pemilik = value!;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      nama_pemilik = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama pemilik tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),

                      const SizedBox(height: 20),

                      // Tombol Submit
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              buatGalang(
                                  request,
                                  tujuan,
                                  judul,
                                  deskripsi,
                                  target.toString(),
                                  tanggal_berakhir,
                                  nama_pemilik,
                                  nama_bank,
                                  no_rekening);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 15,
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const Icon(Icons.info_outline),
                                        const Center(
                                            child: Text(
                                                'Galang Dana berhasil ditambahkan!')),
                                        const SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
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
                            padding:
                                MaterialStateProperty.all(
                                    const EdgeInsets.all(18.0)),
                            backgroundColor:
                                MaterialStateProperty.all(MyColor.darkGreen2),
                          ),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
