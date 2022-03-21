import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

// ignore: must_be_immutable
class InfoRecetas extends StatefulWidget {
  final int indexRecetas;

  const InfoRecetas(this.indexRecetas, {Key? key}) : super(key: key);

  @override
  _InformacionRecetas createState() => _InformacionRecetas();
}

class _InformacionRecetas extends State<InfoRecetas> {
  List _items = [];
  List _ingredientes = [];
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/JSON/recetas.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["items"];
      _ingredientes = data["items"][widget.indexRecetas]["ingredientes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    String title = _items[widget.indexRecetas]["nombre"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Image.asset(_items[widget.indexRecetas]["Imagen"]),
            const Divider(),
            const Text(
              "Ingredientes",
              textScaleFactor: (2),
            ),
            const Divider(),
            _ingredientes.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                    itemCount: _ingredientes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          ListTile(
                            title: Text(_ingredientes[index]["Nombre"]),
                            subtitle: Text(_ingredientes[index]["Cantidad"]),
                          ),
                        ]),
                      );
                    },
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
