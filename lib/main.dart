import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'HomePage.dart';

//! wherever we store data is called box like a table
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //! to ensure of intialize something before running the App we need to write this

  Directory document =
      await getApplicationDocumentsDirectory(); //? getting path object of path provider

  Hive.init(document
      .path); //? we need to get path of the directory for the initialization of hive

  await Hive.openBox("students"); //? alias table name

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
