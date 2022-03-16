import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:recetas_cocina/main.dart';

class InfoRecetas extends StatefulWidget {
  final int indexReceta;
  const InfoRecetas(this.indexReceta);

  @override
  _InformacionRecetas createState() => _InformacionRecetas();
}

class _InformacionRecetas extends State<InfoRecetas> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('/recetas.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    String title = _items[widget.indexReceta]["nombre"];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text(title),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                ListTile(
                  title: Text(_items[widget.indexReceta]["nombre"]),
                  subtitle: Text(_items[widget.indexReceta]["descripcion"]),
                ),
                Column(
                  children: [
                    Image.asset(_items[widget.indexReceta]["Imagen"]),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "Ingredientes",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.3,
                    ),
                  ],
                )
              ])),
        ));
  }
}
