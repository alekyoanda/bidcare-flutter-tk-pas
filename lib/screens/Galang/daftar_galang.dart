import 'package:bidcare/screens/Galang/http_galang.dart';
import 'package:bidcare/screens/Galang/detail_galang.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';

class MyDaftarGalangPage extends StatefulWidget {
  const MyDaftarGalangPage({super.key});

  @override
  State<MyDaftarGalangPage> createState() => _MyDaftarGalangState();
}

class _MyDaftarGalangState extends State<MyDaftarGalangPage> {

  showImage(data){
     if(data == "Keluarga") {
        // Sumber -> https://www.kibrispdr.org/detail-12/gambar-gambar-orang-miskin.html
        return Image.asset('assets/imageGalang/keluarga.jpg',height: 200,);
     } else if (data == "Teman") {
        // Sumber -> https://jatim.tribunnews.com/2019/12/10/4-layanan-pencegahan-bunuh-diri-di-indonesia-yang-bisa-bantu-penderita-depresi-anda-tak-sendiri
        return Image.asset('assets/imageGalang/teman.jpg',height: 200,);
     } else if (data == "Pribadi") {
        // Sumber -> https://www.suara.com/health/2021/07/13/135136/4-cara-membantu-orang-terdekat-yang-telah-didiagnosis-depresi
        return Image.asset('assets/imageGalang/pribadi.jpg',height: 200,);
     } else if (data == "Institusi") {
        // Sumber -> https://man3kotajambi.mdrsh.id/news/5358/kunjungan-ke-panti-asuhan-teratai-jaya.html
        return Image.asset('assets/imageGalang/institusi.jpg',height: 200,);
     } else {
        // Sumber -> https://www.hukumonline.com/berita/a/penjelasan-hukum-soal-tanggung-jawab-pemerintah-atas-bencana-alam-lt600ff4b1191b7/
        return Image.asset('assets/imageGalang/other.jpg',height: 200,);
     }
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Daftar Galang Dana",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white),),
            backgroundColor: MyColor.darkGreen,
            leading: IconButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               icon: const Icon(
                color: Colors.white,
                Icons.arrow_back_ios), 
               //replace with our own icon data.
            )
          ),
        backgroundColor: MyColor.whiteGreen,
        body: SafeArea(

          child:
            ListView( children: [
          
            const SizedBox(height: 20),

            FutureBuilder(
              future: fetchGalang(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada galang dana :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => InkWell(
                        child: GestureDetector(
                          onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDetailGalangPage(
                                        pk: snapshot.data![index].pk,
                                        tujuan: snapshot.data![index].tujuan,
                                        judul: snapshot.data![index].judul,
                                        deskripsi:
                                            snapshot.data![index].deskripsi,
                                        terkumpul:
                                            snapshot.data![index].terkumpul,
                                        target: snapshot.data![index].target,
                                        tanggal_pembuatan: snapshot
                                            .data![index].tanggal_pembuatan,
                                        tanggal_berakhir: snapshot
                                            .data![index].tanggal_berakhir,
                                        status_keaktifan: snapshot
                                            .data![index].status_keaktifan,
                                      )
                                    )
                                  );
                          },

                          child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                          elevation: 5.0,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: showImage(snapshot.data![index].tujuan),
                              ), 
                              ListTile(
                                title: Text(
                                  snapshot.data![index].judul,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: snapshot.data![index].status_keaktifan ?
                                    const Text(
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
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Terkumpul Rp ${snapshot.data![index].terkumpul}",
                                   style: const TextStyle(
                                    color: MyColor.darkGreen,
                                    fontWeight: FontWeight.bold)
                                )
                              ),
                              LinearProgressIndicator(  
                                backgroundColor: MyColor.lightGreen2,  
                                valueColor: const AlwaysStoppedAnimation<Color>(MyColor.darkGreen),  
                                value: snapshot.data![index].terkumpul / snapshot.data![index].target,
                                minHeight: 8 ,
                              ),  
                            ],
                          )
                        ),
                      ),
                      )
                    );
                  }
                }
              },
            )
        ]
      )
      )
    );
  }
}
