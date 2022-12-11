import 'package:bidcare/widgets/accordion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'faq_form.dart';
import 'fetch_faq.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  Future dataFaq = fetchFAQ();

  static List<String> listPertanyaan = [];
  static List<String> listKategori = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(30),
              child: const Text(
                "Frequently Asked Questions",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )),
          FutureBuilder(
              future: dataFaq,
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
                        physics: const ClampingScrollPhysics(),
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
                                    title: snapshot
                                        .data![index].fields.pertanyaan[1],
                                    content:
                                        snapshot.data![index].fields.jawaban,
                                    kategori: snapshot
                                        .data![index].fields.pertanyaan[0],
                                  ),
                                ],
                              ),
                            )));
                  }
                }
              }),
          listPertanyaan.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(
                      top: 30, left: 30, bottom: 15, right: 30),
                  child: const Text(
                    "Pending Questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
              : Container(),
          listPertanyaan.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(
                      top: 0, left: 30, bottom: 20, right: 30),
                  child: const Text(
                    "Tunggu sebentar yaa, customer service kami akan segara menjawab 😊",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ))
              : Container(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: listPertanyaan.length,
              itemBuilder: (context, index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Accordion(
                          title: listPertanyaan[index],
                          content: "",
                          kategori: listKategori[index],
                        ),
                      ],
                    ),
                  )),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(120, 45),
              maximumSize: const Size(150, 45),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqFormPage()),
              );
            },
            child: const Text(
              "Mau Nanya",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

// memasukkan setiap data ke dalam array untuk ditampilkan
void inputPertanyaan(String pertanyaan, String kategori) {
  _FAQPageState.listPertanyaan.add(pertanyaan);
  _FAQPageState.listKategori.add(kategori);
}
