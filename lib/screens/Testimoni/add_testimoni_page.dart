import 'package:flutter/material.dart';
import 'package:bidcare/model/testimoni_model.dart';
import 'package:bidcare/screens/Testimoni/testmoni_page.dart';

import '../../styles/colors.dart';


class AddTestimoniPage extends StatefulWidget {
  const AddTestimoniPage({super.key});

  @override
  State<AddTestimoniPage> createState() => _AddTestimoniPageState();
}

class _AddTestimoniPageState extends State<AddTestimoniPage> {
  final _formKey = GlobalKey<FormState>();
  String nama = "";
  String target = "";
  String pesan = "";
  
  @override
      Widget build(BuildContext context) {
          return Scaffold(
              backgroundColor: MyColor.whiteGreen,
              appBar: AppBar(
                  title: const Text('Testimoni Baru'),
                  backgroundColor: MyColor.darkGreen,
              ),
              // drawer: const NavigatorDrawer(),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Nama",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )
                                ),
                                onChanged: (String? value){
                                  setState(() {
                                    nama = value!;
                                  });
                                },
                                validator: (String? value){
                                  if(value == null || value.isEmpty){
                                    nama = "Anonymous";
                                  }
                                  return null;
                                }          
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Target",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )
                                ),
                                onChanged: (String? value){
                                  setState(() {
                                    target = value!;
                                  });
                                },
                                validator: (String? value){
                                  if(value == null || value.isEmpty){
                                    target = "-";
                                  }
                                  return null;
                                }          
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Pesan",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )
                                ),

                                onChanged: (String? value){
                                  setState(() {
                                    pesan = value!;
                                  });
                                },
                                validator: (String? value){
                                  if(value == null || value.isEmpty){
                                    return 'Pesan tidak boleh kosong!';
                                  }
                                  else if(value.length <= 2){
                                    return 'Isi pesan';
                                  }
                                  return null;
                                }          
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const Text("Notes:\n- Default nama: Anonymous\n- Jika bukan resipien, maka abaikan target",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              // addTestimoni(nama, pesan, target);
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const TestimoniPage()));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                          ),
                          child: const Text("Buat Testimoni Baru", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          );
      }
}