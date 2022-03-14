import 'dart:html';

import 'package:flutter/material.dart';
import 'package:recetas_cocina/cards.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'UwU',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Recetas UwU',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(25),
                          child: InkWell(
                              onTap: () {
                                final route =
                                    MaterialPageRoute(builder: (context) {
                                  print(index);
                                  return uwu();
                                });
                                Navigator.push(context, route);
                              },
                              child: Column(children: [
                                ListTile(
                                  leading: Text(_items[index]["id"]),
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
                : Container()
          ],
        ),
      ),
    );
  }
}
