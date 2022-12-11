import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;
  final String kategori;

  const Accordion({Key? key, required this.title, required this.content, required this.kategori})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      color: widget.kategori.toUpperCase() == "UMUM" ? Colors.teal : 
             widget.kategori.toUpperCase() == "GALANG" ? const Color.fromARGB(255, 62, 186, 107) : const Color.fromARGB(255, 71, 131, 93), 
      child: Column(children: [
        ListTile(
          // contentPadding: const EdgeInsetsDirectional.all(8),
          leading: widget.kategori.toUpperCase() == "UMUM" ? const Icon(Icons.help, color: Colors.white) : 
                   widget.kategori.toUpperCase() == "GALANG" ? const Icon(Icons.monetization_on_rounded, color: Colors.white) : 
                   const Icon(Icons.gavel_rounded, color: Colors.white,),
          minLeadingWidth : 25, 
          minVerticalPadding: 15,
          title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          onTap: widget.content != "" ? () {
              setState(() {
                _showContent = !_showContent;
              });
            } : null,
          trailing: widget.content != "" ? Icon( _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down) : null,
        ),
        _showContent ? 
          Container(
              width: double.infinity,
              color: Colors.white70,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(widget.content, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            )
          : Container()
      ]),
    );
  }
}