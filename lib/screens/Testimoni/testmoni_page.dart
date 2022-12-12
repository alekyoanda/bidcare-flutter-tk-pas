import 'package:flutter/material.dart';
import 'package:bidcare/model/Testimoni/testimoni_model.dart';
import 'package:bidcare/screens/Testimoni/add_testimoni_page.dart';
import 'package:bidcare/styles/colors.dart';

class TestimoniPage extends StatefulWidget {
  const TestimoniPage({super.key});

  @override
  State<TestimoniPage> createState() => _TestimoniPageState();
}

class _TestimoniPageState extends State<TestimoniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      appBar: AppBar(
        title: const Text('Testimoni BidCare'),
        backgroundColor: MyColor.darkGreen,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: MyColor.darkGreen2,
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
            child: const Text("Buat Testimoni Baru", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [MyColor.lightGreen2, MyColor.lightGreen1]
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 8,
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                "From: ${snapshot.data![index].fields.nama}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Target: ${snapshot.data![index].fields.target}",
                              style: TextStyle(
                                fontSize: 14,
                                background: Paint()
                                  ..color = Colors.white
                                  ..strokeWidth = 20
                                  ..strokeJoin = StrokeJoin.round
                                  ..strokeCap = StrokeCap.round
                                  ..style = PaintingStyle.stroke,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 5),
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