import 'package:bidcare/model/pertanyaan.dart';
import 'package:bidcare/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import 'faq_page.dart';

class FaqFormPage extends StatefulWidget {
    const FaqFormPage({super.key});

    @override
    State<FaqFormPage> createState() => _FaqFormState();
}

class _FaqFormState extends State<FaqFormPage> {
    final _formKey = GlobalKey<FormState>();

    String _pertanyaan = "";
    late String _kategori = "Umum";
    List<String> listKategori = ['Umum', 'Galang', 'Lelang'];
   
    bool isNumeric(String value){
        return int.tryParse(value) != null;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: MyColor.whiteGreen,

            appBar: AppBar(
                title: const Text('Customer Service', style: TextStyle(color: Colors.white),),
                backgroundColor: MyColor.darkGreen,
                leading: BackButton(
                  onPressed: () => Navigator.pushNamed(context, "/faq_page")
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
                                Container(
                                  margin: const EdgeInsets.all(50),
                                  child: const Text(
                                    "Form Pertanyaan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: MyColor.darkGreen),
                                  )
                                ),

                                const SizedBox(height: 30),
                                
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(20.0),
                                    child: DropdownButtonFormField(
                                        // disabledHint: Text('Pilih Kategori Pertanyaan'),
                                        borderRadius: BorderRadius.circular(10.0),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          ),
                                        alignment: AlignmentDirectional.centerStart,
                                        hint: const Text('Pilih Kategori Pertanyaan'),
                                        value: _kategori,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: listKategori.map((String items) {
                                            return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                            );
                                        }).toList(),
                                      
                                        onChanged: (String? newValue) {
                                            setState(() {
                                            _kategori = newValue!;
                                            });
                                        },
                                        
                                    
                                    ),
                                
                                ),

                                const SizedBox(height: 20),

                                Padding(
                                    // Menggunakan padding sebesar 8 pixels
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Aku mau nanya..",
                                            labelText: "Pertanyaan",
                                            // Menambahkan circular border agar lebih rapi
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                            ),
                                        ),
                                        // Menambahkan behavior saat nama diketik 
                                        onChanged: (String? value) {
                                            setState(() {
                                                _pertanyaan = value!;
                                            });
                                        },
                                        // Menambahkan behavior saat data disimpan
                                        onSaved: (String? value) {
                                            setState(() {
                                                _pertanyaan = value!;
                                            });
                                        },
                                        // Validator sebagai validasi form
                                        validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                                return 'Pertanyaan tidak boleh kosong!';
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
                                          _kategori = _kategori == "Umum" ? "UMUM" : 
                                                      _kategori == "Galang" ? "GALANG" : "LELANG";

                                          Pertanyaan newPertanyaan = Pertanyaan(kategori: _kategori, teksPertanyaan: _pertanyaan);
                                          inputPertanyaan(newPertanyaan);
                                          
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const FAQPage()),
                                          );
                                      }
                                  },
                                  text: const Text(
                                      "Kirim",
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
