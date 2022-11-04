import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final option = Provider.of<Options>(context, listen: false);
    return Drawer(
      width: screenSize.width * 0.50,
      child: Column(
        children: [
          //Main text
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: screenSize.height * 0.10,
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                SizedBox(
                  width: screenSize.width * 0.35,
                  child: Text(
                    'Olá ${option.username}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //Category button
          SizedBox(
            height: 30,
            width: screenSize.width * 0.50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/categorypage');
              },
              child: Row(
                children: const [
                  SizedBox(width: 5),
                  Icon(Icons.category),
                  SizedBox(width: 5),
                  Text("Categorias"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //Profile button
          SizedBox(
            height: 30,
            width: screenSize.width * 0.50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/profilepage');
              },
              child: Row(
                children: const [
                  SizedBox(width: 5),
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text("Perfil"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //Configuration button
          SizedBox(
            height: 30,
            width: screenSize.width * 0.50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/configurationpage');
              },
              child: Row(
                children: const [
                  SizedBox(width: 5),
                  Icon(Icons.settings),
                  SizedBox(width: 5),
                  Text("Configurações"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
