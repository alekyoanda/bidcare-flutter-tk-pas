import 'package:bidcare/model/galang_dana_model.dart';
import 'package:bidcare/model/lelang/barang_lelang_model.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../styles/colors.dart';
import '../lelang/lelang_rincian.dart';

class LihatGalang extends StatefulWidget {
  const LihatGalang({
    Key? key,
  }) : super(key: key);

  @override
  State<LihatGalang> createState() => _LihatGalangState();
}

class _LihatGalangState extends State<LihatGalang> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<GalangDana>> fetchLelang() async {
      final response = await request.get('https://bidcare.up.railway.app/get_galang2/json/');
      // print(response);
      List<GalangDana> listGalang = [];

      for (var d in response) {
        // print("anu");
        print(d);
        if (d != null) {
          listGalang.add(GalangDana.fromJson(d));
        }
      }
      // print(listGalang);
      return listGalang;
    }
    // final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      appBar: AppBar(
        title: const Text('Galang Dana Anda'),
        backgroundColor: MyColor.lightGreen2,
      ),
    body: FutureBuilder(
      future: fetchLelang(),
      builder: (context, AsyncSnapshot snapshot) {
        // print(snapshot.data);
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data.length == 0) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Kamu belum pernah menggalang,\n yuk mulai Galang Dana di Bidcare :)",
                  style: TextStyle(color: MyColor.darkGreen2, fontSize: 40, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
              ],
            ),
            );
          } else {
            // ini harus diubah jadi return listview builder
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(color: snapshot.data?[index].fields.statusKeaktifan == false ? Colors.red : Colors.green, blurRadius: 2.0)
                    ]),
                child: Center(
                  child: Column(children: [
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center( 
                              child: 
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      color: MyColor.darkGreen,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                    child: Text(
                                      "${snapshot.data?[index].fields.judul}"),
                                  ),
                                ),
                            ),
                            Center( 
                              child: 
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      color: MyColor.darkGreen,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                    child: Text(
                                      "${snapshot.data?[index].fields.deskripsi}"),
                                  ),
                                ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[ 
                                      const DefaultTextStyle(
                                      style:  TextStyle(
                                        color: MyColor.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                      child: Text(
                                        "Target"),
                                      ),
                                      DefaultTextStyle(
                                      style: const TextStyle(
                                        color: MyColor.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                      child: Text(
                                        "${snapshot.data?[index].fields.target}"),
                                      ),
                                    ]
                                  ),
                                ),

                            
                                Padding(
                                  padding: EdgeInsets.only(left:20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[ 
                                      const DefaultTextStyle(
                                      style:  TextStyle(
                                        color: MyColor.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                      child: Text(
                                        "Terkumpul"),
                                      ),
                                      DefaultTextStyle(
                                      style: const TextStyle(
                                        color: MyColor.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                      child: Text(
                                        "${snapshot.data?[index].fields.terkumpul}"),
                                      ),
                                    ]
                                  ),
                                ),
                              ]
                            ),
                            Container(
                      height: 50,
                      width: 120,
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          // maximumSize: const Size.fromWidth(50),
                          backgroundColor: MyColor.darkGreen,
                        ),
                        child: const Text('Detail'),
                        onPressed: () async {
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyLelangRincianPage(
                                          lelang_id: snapshot.data![index].pk,
                                        ),
                                      ),
                                    );
                        }
                            )),
                          ]),
                    ),
                  ]),
                ),
              ),
            );
          }
        }
      },
    )
    );
  }
}