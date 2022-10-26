import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = 'Leandro';
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      width: screenSize.width * 0.50,
      child: Column(
        children: [
          Container(
            color: Colors.lightGreen,
            width: double.infinity,
            height: screenSize.height * 0.10,
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                Text('Olá $usuario'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
