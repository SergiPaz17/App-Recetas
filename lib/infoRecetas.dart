import 'dart:math';
import 'dart:ui';

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
  List _pasos = [];
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/JSON/recetas.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["items"];
      _ingredientes = data["items"][widget.indexRecetas]["ingredientes"];
      _pasos = data["items"][widget.indexRecetas]["pasos"];
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
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
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ingredientes.length,
                      shrinkWrap: true,
                      itemExtent: 40,
                      itemBuilder: (context, index) {
                        return Row(children: [
                          Text(_ingredientes[index]["Nombre"] + ": "),
                          Text(_ingredientes[index]["Cantidad"] + " "),
                          const Spacer(),
                          const Icon(Icons.shopping_cart),
                        ]);
                      },
                    )
                  : Container(),
              const Divider(),
              const Text(
                "Pasos",
                textScaleFactor: (2),
              ),
              const Divider(),
              _pasos.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pasos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Row(
                            children: [
                              Text(
                                "Paso " + index.toString(),
                                textScaleFactor: 1.2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(_pasos[index]["paso"]),
                          const Text(""),
                        ]);
                      },
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          margin: const EdgeInsets.all(25),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InfoRecetas(index),
                                  ),
                                );
                              },
                              child: Column(children: [
                                ListTile(
                                  title: Text(_items[index]["nombre"]),
                                  subtitle: Text(_items[index]["descripcion"]),
                                ),
                                Column(
                                  children: [
                                    Image.asset(_items[index]["Imagen"]),
                                  ],
                                )
                              ])),
                        );
                      },
                    ),
              Container(
                height: 500,
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: const EdgeInsets.all(25),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoRecetas(index),
                              ),
                            );
                          },
                          child: Column(children: [
                            ListTile(
                              title: Text(_items[index]["nombre"]),
                              subtitle: Text(_items[index]["descripcion"]),
                            ),
                            Column(
                              children: [
                                Image.asset(_items[index]["Imagen"]),
                              ],
                            )
                          ])),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
