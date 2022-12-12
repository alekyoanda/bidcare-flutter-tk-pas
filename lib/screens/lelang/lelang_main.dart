import 'dart:ffi';

import 'package:bidcare/model/lelang/barang_lelang_model.dart';
import 'package:bidcare/providers/all_barang_lelang.dart';
import 'package:bidcare/screens/lelang/lelang_rincian.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

import '../../widgets/card_lelang_builder,.dart';
import '../../widgets/my_search_bar.dart';
import '../../widgets/my_text_icon_button.dart';

class MyLelangMainPage extends StatefulWidget {
  const MyLelangMainPage({super.key});

  @override
  State<MyLelangMainPage> createState() => _MyLelangMainPageState();
}

class _MyLelangMainPageState extends State<MyLelangMainPage> {
  bool onRefresh = false;
  @override
  Widget build(BuildContext context) {
    String? keySearch = null;
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        color: MyColor.green1,
        onRefresh: () async {
          onRefresh = true;
          context.read<AllBarangLelang>().barangLelangOnRefresh();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          children: [
            MySearchBar(
              hintText: "Cari Barang Lelang..",
              historyKey: "01",
              onSubmitted: (p0) {
                keySearch = p0;
                context.read<AllBarangLelang>().barangLelangOnSearch();
              },
            ),
            StickyHeader(
              header: Container(
                decoration: const BoxDecoration(
                  color: MyColor.whiteGreen,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextIconButton(
                          text: "Kategori",
                          icon: const Icon(
                            Icons.category,
                            color: MyColor.green1,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const VerticalDivider(
                        width: .5,
                        thickness: .5,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: MyTextIconButton(
                          text: "Urutkan",
                          icon: const Icon(
                            Icons.filter_list,
                            color: MyColor.green1,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              content: Consumer<AllBarangLelang>(
                builder: (context, value, child) {
                  return FutureBuilder(
                    initialData: (onRefresh)
                        ? context.read<AllBarangLelang>().daftarBarangLelang
                        : null,
                    future: (context
                        .read<AllBarangLelang>()
                        .fetchBarangLelang(key: keySearch)),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                            margin: const EdgeInsets.only(top: 32),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: MyColor.green1,
                            )));
                      } else {
                        if (!snapshot.hasData) {
                          return Column(
                            children: const [
                              Text(
                                "Tidak ada barang lelang :(",
                                style: TextStyle(
                                    color: Color(0xff59A5D8), fontSize: 20),
                              ),
                              SizedBox(height: 4),
                            ],
                          );
                        } else {
                          onRefresh = false;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) =>
                                cardLelangBuilder(context, snapshot, index),
                          );
                        }
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
