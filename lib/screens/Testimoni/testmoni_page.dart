import 'package:flutter/material.dart';
import 'package:bidcare/model/testimoni_model.dart';
import 'package:bidcare/screens/Testimoni/add_testimoni_page.dart';

class TestimoniPage extends StatefulWidget {
  const TestimoniPage({super.key});

  @override
  State<TestimoniPage> createState() => _TestimoniPageState();
}

class _TestimoniPageState extends State<TestimoniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testimoni BidCare'),
      ),
      // drawer: const NavigatorDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF34765f),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text("Here are our user testimonials about BidCare",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddTestimoniPage()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
            ),
            child: const Text("Buat Testimoni Baru", style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 30),
          FutureBuilder(
            future: fetchTestimoni(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Text(
                    "Tidak ada Testimoni",
                    style: TextStyle(color: Color(0xff59A5D8),fontSize: 20));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index)=> InkWell(
                        child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(4.0, 3.0)
                            )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].fields.pesan}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                "From: ${snapshot.data![index].fields.nama}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Target: ${snapshot.data![index].fields.target}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),  
                    )
                  ),
                );
              }
            }
          }
          )
        ],
      )
    );
  }
}