import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'main.dart';

int sumar = 1;
bool theme = true;
bool isActive = false;
bool isCheck = false;
bool a = true;

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
        title: Text(title),
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              }),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              Visibility(
                child: Column(
                  children: [
                    Image.asset(_items[widget.indexRecetas]["Imagen"]),
                    const Divider(),
                    const Text(
                      "Ingredientes",
                      textScaleFactor: (2),
                    ),
                  ],
                ),
                visible: isActive,
              ),
              Visibility(
                child: Column(
                  children: [
                    const Divider(),
                    const Text(
                      "rurgfhuszhdjlh",
                      textScaleFactor: (2),
                    ),
                  ],
                ),
                visible: !isActive,
              ),
              IconButton(
                  onPressed: () {
                    isActive = !isActive;
                  },
                  icon: const Icon(Icons.youtube_searched_for)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (sumar <= 5) {
                          sumar++;
                        }
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        if (sumar >= 2) {
                          sumar--;
                        }
                      },
                      icon: const Icon(Icons.remove)),
                ],
              ),
              Text("Recetas para " + sumar.toString() + " personas"),
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
                          const Spacer(),
                          Text((_ingredientes[index]["Cantidad"] * sumar)
                                  .toString() +
                              " "),
                          Text(_ingredientes[index]["Tipo"]),
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
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.platform,
                            checkColor: Colors.white,
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value!;
                              });
                            },
                          ),
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
              const Divider(
                thickness: 2,
              ),
              const Text("Otras recetas", textScaleFactor: (2)),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 1.1),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: const EdgeInsets.all(20),
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
                                Image.asset(
                                  _items[index]["Imagen"],
                                ),
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
