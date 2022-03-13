import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mixin_note/injection.dart';

void main() {
  configureDependencies(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material app bar'),
        ),
        body: const Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }
}
