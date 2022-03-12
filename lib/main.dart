import 'package:flutter/material.dart';
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
            ElevatedButton(
              child: const Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.all(25),
                            child: Column(children: [
                              ListTile(
                                leading: Text(_items[index]["id"]),
                                title: Text(_items[index]["nombre"]),
                                subtitle: Text(_items[index]["descripcion"]),
                              ),
                              Column(
                                children: [
                                  Text(_items[index]["Ingrediente1"]),
                                  Text(_items[index]["Ingrediente2"]),
                                  Text(_items[index]["Ingrediente3"]),
                                  Text(_items[index]["Ingrediente4"]),
                                  Text(_items[index]["Ingrediente5"]),
                                  Text(_items[index]["Paso1"]),
                                  Text(_items[index]["Paso2"]),
                                  Text(_items[index]["Paso3"]),
                                  Text(_items[index]["Paso4"]),
                                  Text(_items[index]["Paso5"]),
                                ],
                              )
                            ]));
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
