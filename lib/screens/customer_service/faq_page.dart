import 'package:bidcare/model/faq/pertanyaan.dart';
import 'package:bidcare/screens/customer_service/pertanyaan_page.dart';
import 'package:bidcare/widgets/accordion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../../widgets/my_elevated_button.dart';
import 'faq_form.dart';
import 'fetch_cs.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  Future dataFaq = fetchFAQ();
  Future dataPertanyaan = fetchPertanyaan();

  // static List<Pertanyaan> listPertanyaan = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      appBar: AppBar(
          title: const Text(
            'Customer Service',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: MyColor.darkGreen,
          leading: BackButton(
              onPressed: () => Navigator.pushNamed(context, "/dashboard"))),

      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),

          Container(
            margin: const EdgeInsets.all(40),
            child: const Text(
              "Frequently Asked Questions",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: MyColor.darkGreen),
            )
          ),

          FutureBuilder(
            future: dataFaq,
            // future: dataPertanyaan,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada faq :(",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                          child: Container(
                          margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Accordion(
                                title: snapshot.data![index].fields.pertanyaan[1],
                                content: snapshot.data![index].fields.jawaban,
                                kategori: snapshot.data![index].fields.pertanyaan[0],
                              ),
                            ],
                          ),
                        )
                      )
                    );
                }
              }
            }),

          const SizedBox(
            height: 30,
          ),

          Center(
            child: MyElevatedButton(
            backgroundColor: MyColor.green1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqFormPage()),
              );
            },
              text: const Text(
                "Mau Nanya",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ),

          const SizedBox(
            height: 20,
          ),

          Center(
            child: MyElevatedButton(
            backgroundColor: MyColor.green1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PertanyaanPage()),
              );
            },
              text: const Text(
                "Lihat Pending Questions",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ),

          // listPertanyaan.isNotEmpty ? Container(
          //   margin: const EdgeInsets.only(
          //       top: 30, left: 30, bottom: 15, right: 30),
          //   child: const Text(
          //     "Pending Questions",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20,
          //         color: MyColor.darkGreen),
          //   ))
          // : Container(),

          // listPertanyaan.isNotEmpty ? Container(
          //   margin: const EdgeInsets.only(
          //       top: 0, left: 30, bottom: 20, right: 30),
          //   child: const Text(
          //     "Tunggu sebentar yaa, customer service kami akan segara menjawab ????",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //         color: MyColor.darkGreen),
          //   ))
          //   : Container(),

          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: listPertanyaan.length,
          //   itemBuilder: (context, index) => Container(
          //     margin:
          //         const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          //     padding: const EdgeInsets.all(0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Accordion(
          //           title: listPertanyaan[index].teksPertanyaan,
          //           content: "",
          //           kategori: listPertanyaan[index].kategori,
          //         ),
          //       ],
          //     ),
          //   )),

          const SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}

// // memasukkan setiap data ke dalam array untuk ditampilkan
// void inputPertanyaan(Pertanyaan newPertanyaan) {
//   _FAQPageState.listPertanyaan.add(newPertanyaan);
// }
