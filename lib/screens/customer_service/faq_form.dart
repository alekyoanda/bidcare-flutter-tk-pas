import 'package:flutter/material.dart';
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
            appBar: AppBar(
                title: const Text('Form FAQ'),
            ),
            
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(20.0),
                                    child: DropdownButton(
                                        // disabledHint: Text('Pilih Kategori Pertanyaan'),
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

                                Padding(
                                    // Menggunakan padding sebesar 8 pixels
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Aku mau nanya..",
                                            labelText: "Pertanyaan",
                                            // Menambahkan icon agar lebih intuitif
                                            // icon: const Icon(Icons.people),
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
                                
                            ], 
                        ),

                    ),

                ),

            ),

            floatingActionButton: Container( 
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(left: 30),
                child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        _kategori = _kategori == "Umum" ? "UMUM" : 
                                    _kategori == "Galang" ? "GALANG" : "LELANG";
                        inputPertanyaan(_pertanyaan, _kategori);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FAQPage()),
                        );
                    }
                },
                child: const Text(
                    "Kirim",
                    style: TextStyle(color: Colors.white),
                ),
            ),
            ),
        );
    }
}
