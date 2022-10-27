import 'package:flutter/material.dart';
import 'package:malugos_project/pages/drawer_page/configurationpage.dart';
import 'package:malugos_project/pages/drawer_page/profilepage.dart';
import 'package:malugos_project/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Malugos',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/configurationpage': (context) => const ConfigurationPage(),
        '/profilepage': (context) => const ProfilePage(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
