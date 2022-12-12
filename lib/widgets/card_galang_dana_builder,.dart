import 'package:flutter/material.dart';

import '../screens/Galang/detail_galang.dart';
import '../screens/Galang/http_galang.dart';
import '../styles/colors.dart';

showImage(data) {
    if (data == "Keluarga") {
      // Sumber -> https://www.kibrispdr.org/detail-12/gambar-gambar-orang-miskin.html
      return Image.asset('assets/imageGalang/keluarga.jpg',
          height: 200, fit: BoxFit.cover);
    } else if (data == "Teman") {
      // Sumber -> https://jatim.tribunnews.com/2019/12/10/4-layanan-pencegahan-bunuh-diri-di-indonesia-yang-bisa-bantu-penderita-depresi-anda-tak-sendiri
      return Image.asset('assets/imageGalang/teman.jpg',
          height: 200, fit: BoxFit.cover);
    } else if (data == "Pribadi") {
      // Sumber -> https://www.suara.com/health/2021/07/13/135136/4-cara-membantu-orang-terdekat-yang-telah-didiagnosis-depresi
      return Image.asset('assets/imageGalang/pribadi.jpg',
          height: 200, fit: BoxFit.cover);
    } else if (data == "Institusi") {
      // Sumber -> https://man3kotajambi.mdrsh.id/news/5358/kunjungan-ke-panti-asuhan-teratai-jaya.html
      return Image.asset('assets/imageGalang/institusi.jpg',
          height: 200, fit: BoxFit.cover);
    } else {
      // Sumber -> https://www.hukumonline.com/berita/a/penjelasan-hukum-soal-tanggung-jawab-pemerintah-atas-bencana-alam-lt600ff4b1191b7/
      return Image.asset('assets/imageGalang/other.jpg',
          height: 200, fit: BoxFit.cover);
    }
}

InkWell cardGalangDanaBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    return InkWell(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyDetailGalangPage(
                                            pk: snapshot.data![index].pk,
                                            user: snapshot.data![index].user,
                                            tujuan:
                                                snapshot.data![index].tujuan,
                                            judul:
                                                snapshot.data![index].judul,
                                            deskripsi: snapshot
                                                .data![index].deskripsi,
                                            terkumpul: snapshot
                                                .data![index].terkumpul,
                                            target:
                                                snapshot.data![index].target,
                                            tanggal_pembuatan: snapshot
                                                .data![index]
                                                .tanggal_pembuatan,
                                            tanggal_berakhir: snapshot
                                                .data![index]
                                                .tanggal_berakhir,
                                            status_keaktifan: snapshot
                                                .data![index]
                                                .status_keaktifan,
                                          )));
                            },
                            child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 16),
                                elevation: 5.0,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      child: showImage(
                                          snapshot.data![index].tujuan),
                                    ),
                                    ListTile(
                                      title: Text(
                                        snapshot.data![index].judul,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: snapshot
                                              .data![index].status_keaktifan
                                          ? const Text(
                                              "Aktif",
                                              style: TextStyle(
                                                  color: Colors.red),
                                            )
                                          : const Text(
                                              "Tidak Aktif",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            
                                    ),
                                    FutureBuilder(
                                      future: fetchAkunGalang(
                                          snapshot.data![index].user),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text(
                                            "",
                                          );
                                        } else {
                                          return ListView.builder(
                                              itemCount:
                                                  snapshot.data!.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (_, index) => InkWell(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15),
                                                          child: Center(
                                                              child: Column(
                                                                  children: [
                                                                Row(
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            const EdgeInsets.only(right: 5),
                                                                        child:
                                                                            const Icon(
                                                                          Icons.person,
                                                                          color:
                                                                              MyColor.darkGreen,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          '${snapshot.data![index].username}',
                                                                          style:
                                                                              const TextStyle(
                                                                            color: MyColor.darkGreen,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15,
                                                                          ))
                                                                    ]),
                                                              ])),
                                                        ),
                                                      ));
                                        }
                                      },
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(16.0),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "Terkumpul Rp ${snapshot.data![index].terkumpul}",
                                            style: const TextStyle(
                                                color: MyColor.darkGreen,
                                                fontWeight:
                                                    FontWeight.bold))),
                                    LinearProgressIndicator(
                                      backgroundColor: MyColor.lightGreen2,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              MyColor.darkGreen),
                                      value: snapshot.data![index].terkumpul /
                                          snapshot.data![index].target,
                                      minHeight: 8,
                                    ),
                                  ],
                                )),
                          ),
                        );
  }