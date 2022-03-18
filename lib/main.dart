import 'dart:html';

import 'package:flutter/material.dart';
import 'package:recetas_cocina/infoRecetas.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

bool? a;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      debugShowCheckedModeBanner: false,
      title: 'UwU',
      home: const HomePage(),
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

  //* Fetch content from the json file
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
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
