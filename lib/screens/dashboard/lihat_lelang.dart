import 'package:bidcare/model/lelang/barang_lelang_model.dart';
import 'package:bidcare/widgets/card_lelang_builder,.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../styles/colors.dart';
import '../lelang/lelang_rincian.dart';

class LihatLelang extends StatefulWidget {
  const LihatLelang({
    Key? key,
  }) : super(key: key);

  @override
  State<LihatLelang> createState() => _LihatLelangState();
}

class _LihatLelangState extends State<LihatLelang> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<BarangLelang>> fetchLelang() async {
      final response =
          await request.get('https://bidcare.up.railway.app/get_lelang2/json/');
      // print(response);
      List<BarangLelang> listLelang = [];

      for (var d in response) {
        // print("anu");
        // print(d);
        if (d != null) {
          listLelang.add(BarangLelang.fromJson(d));
        }
      }
      return listLelang;
    }

    // final request = context.watch<CookieRequest>();
    return Scaffold(
        backgroundColor: MyColor.whiteGreen,
        appBar: AppBar(
          title: const Text('Lelang Anda'),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Kamu belum pernah melelang,\n yuk mulai Lelang di Bidcare :)",
                        style: TextStyle(
                            color: MyColor.darkGreen2,
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              } else {
                // ini harus diubah jadi return listview builder
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (_, index) =>
                          cardLelangBuilder(context, snapshot, index),
                    ),
                  ),
                );
              }
            }
          },
        ));
  }
}
