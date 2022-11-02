import 'package:flutter/material.dart';
import 'package:malugos_project/pages/authpage.dart';
import 'package:malugos_project/pages/drawer_page/categorypage.dart';
import 'package:malugos_project/pages/drawer_page/configurationpage.dart';
import 'package:malugos_project/pages/drawer_page/profilepage.dart';
import 'package:malugos_project/pages/featurepage.dart';
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
        '/authpage': (context) => const AuthPage(),
        '/homepage': (context) => const HomePage(),
        '/categorypage': (context) => const CategoryPage(),
        '/configurationpage': (context) => const ConfigurationPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/featurepage': (context) => const FeaturePage(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage();
  }
}
