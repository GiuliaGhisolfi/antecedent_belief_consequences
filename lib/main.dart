import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'savedata.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'ABC',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 200, 234, 255),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 150, 208, 245)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Home'),
      ),
    );
  }
}