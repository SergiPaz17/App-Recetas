import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'infoRecetas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'App Recetas',
            theme: ThemeData(primarySwatch: Colors.grey),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const HomePage(),
          );
        });
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
    final String response =
        await rootBundle.loadString('assets/JSON/recetas.json');
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
          'Recetas',
        ),
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
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
