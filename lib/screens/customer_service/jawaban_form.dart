import 'package:bidcare/model/faq/faq.dart';
import 'package:bidcare/model/faq/pertanyaan.dart';
import 'package:bidcare/screens/customer_service/fetch_cs.dart';
import 'package:bidcare/screens/customer_service/pertanyaan_page.dart';
import 'package:bidcare/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../styles/colors.dart';
import 'faq_page.dart';

class JawabanFormPage extends StatefulWidget {
    const JawabanFormPage({super.key, required this.jawabPertanyaan});
    final Pertanyaan jawabPertanyaan;

    @override
    State<JawabanFormPage> createState() => _JawabanFormState();
}

class _JawabanFormState extends State<JawabanFormPage> {
    final _formKey = GlobalKey<FormState>();

    String _jawaban = "";
    // String? _kategori;
    // List<String> listKategori = ['Umum', 'Galang', 'Lelang'];
    bool isValid = false;
   
    bool isNumeric(String value){
        return int.tryParse(value) != null;
    }

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
        return Scaffold(
            backgroundColor: MyColor.whiteGreen,

            appBar: AppBar(
                title: const Text('Customer Service', style: TextStyle(color: Colors.white),),
                backgroundColor: MyColor.darkGreen,
                leading: BackButton(
                  onPressed: () => Navigator.pushNamed(context, "/pertanyaan_page")
                )
            ),
            
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                const SizedBox(height: 10),

                                Container(
                                  margin: const EdgeInsets.all(50),
                                  child: const Text(
                                    "Form Jawaban",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: MyColor.darkGreen),
                                  )
                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 0, left: 30, bottom: 20, right: 30),
                                  child: Text(
                                    widget.jawabPertanyaan.teksPertanyaan,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: MyColor.darkGreen),
                                )),
                                
                                const SizedBox(height: 50),

                                Padding(
                                    // Menggunakan padding sebesar 8 pixels
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Jawaban..",
                                            labelText: "Jawaban",
                                            // Menambahkan circular border agar lebih rapi
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                            ),
                                        ),
                                        // Menambahkan behavior saat nama diketik 
                                        onChanged: (String? value) {
                                            setState(() {
                                                _jawaban = value!;
                                            });
                                        },
                                        // Menambahkan behavior saat data disimpan
                                        onSaved: (String? value) {
                                            setState(() {
                                                _jawaban = value!;
                                            });
                                        },
                                        // Validator sebagai validasi form
                                        validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                                return 'Jawaban tidak boleh kosong!';
                                            }
                                            return null;
                                        },
                                    ),
                                ),


                                const SizedBox(height: 120),

                                MyElevatedButton(
                                  backgroundColor: MyColor.green1,
                                  onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // List<String> pertanyaan = [widget.jawabPertanyaan.kategori, widget.jawabPertanyaan.teksPertanyaan];
                                        // inputPertanyaan(newPertanyaan);
                                        buatFaq(request, widget.jawabPertanyaan.teksPertanyaan, _jawaban, widget.jawabPertanyaan.pk) ;
                                        
                                        isValid = true;

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const PertanyaanPage()),
                                        );
                                          
                                      }

                                      isValid? showDialog(context: context, builder: (BuildContext context) { 
                                        return const AlertDialog(
                                        title: Text("Terima kasih!"),
                                          content: Text("Pertanyaan berhasil dijawab"),
                                        );
                                        }
                                      ) : null;

                                  },

                                  text: const Text(
                                      "Jawab",
                                      style: TextStyle(color: Colors.white),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              
                                MyElevatedButton(
                                  backgroundColor: const Color.fromARGB(255, 140, 13, 13),
                                  onPressed: () {
                                    deletePertanyaan(widget.jawabPertanyaan.pk);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PertanyaanPage()),
                                    );

                                    showDialog(context: context, builder: (BuildContext context) { 
                                      return const AlertDialog(
                                      title: Text("Succeed!"),
                                        content: Text("Pertanyaan berhasil dihapus"),
                                      );
                                      }
                                    );

                                  },

                                  text: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                
                            ], 
                        ),

                    ),

                ),

            ),
            
        );
    }
}
