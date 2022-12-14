import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.lightGreen,
        child: FittedBox(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              child: const Text(
                ':)',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
