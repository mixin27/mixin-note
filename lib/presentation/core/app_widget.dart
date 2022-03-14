import 'package:flutter/material.dart';

import '../sign_in/sign_in_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mixin Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.purple[800],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amberAccent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const SignInPage(),
    );
  }
}
