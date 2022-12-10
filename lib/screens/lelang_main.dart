import 'dart:ffi';

import 'package:bidcare/model/barang_lelang_model.dart';
import 'package:bidcare/providers/all_barang_lelang.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';

import '../widgets/my_search_bar.dart';
import '../widgets/my_text_icon_button.dart';

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
                            itemBuilder: (_, index) => IntrinsicHeight(
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: InkWell(
                                  onTap: () {
                                    print(Provider.of<AllBarangLelang>(context,
                                            listen: false)
                                        .daftarBarangLelang[index]
                                        .fields
                                        .namaBarang
                                        .toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          child: const VerticalDivider(
                                            width: 1,
                                            thickness: .5,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Image.asset(
                                          'images/${snapshot.data![index].fields.gambar}',
                                          height: 100,
                                          width: 160,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'images/lelang/product-image-placeholder.jpg',
                                              height: 100,
                                              width: 160,
                                            );
                                          },
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: const VerticalDivider(
                                            width: 1,
                                            thickness: .5,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: Text(
                                                  snapshot.data![index].fields
                                                      .namaBarang,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Bid tertinggi",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                      Text(
                                                        "Rp${NumberFormat('#,###').format(snapshot.data![index].fields.bidTertinggi).toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 13.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "Sisa waktu",
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                        Text(
                                                          '${snapshot.data![index].fields.tanggalBerakhir.difference(DateTime.now()).inDays.toString()} hari',
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
