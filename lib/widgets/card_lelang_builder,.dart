import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/lelang/lelang_rincian.dart';
import '../styles/colors.dart';

IntrinsicHeight cardLelangBuilder(
    BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
  return IntrinsicHeight(
    child: Card(
      surfaceTintColor: MyColor.darkGreen,
      shadowColor: MyColor.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyLelangRincianPage(
                lelang_id: snapshot.data![index].pk,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
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
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'images/lelang/product-image-placeholder.jpg',
                    height: 100,
                    width: 160,
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: const VerticalDivider(
                  width: 1,
                  thickness: .5,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        snapshot.data![index].fields.namaBarang,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bid tertinggi",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600]),
                            ),
                            Text(
                              "Rp${NumberFormat('#,###').format(snapshot.data![index].fields.bidTertinggi).toString()}",
                              style: const TextStyle(
                                  fontSize: 13.5, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Sisa waktu",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[600]),
                              ),
                              Text(
                                (snapshot.data![index].fields.statusKeaktifan)
                                    ? '${snapshot.data![index].fields.tanggalBerakhir.difference(DateTime.now()).inDays.toString()} hari'
                                    : "Lelang selesai",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: (snapshot.data![index].fields
                                            .statusKeaktifan)
                                        ? MyColor.darkGreen
                                        : Colors.red,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
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
  );
}
