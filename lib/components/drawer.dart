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
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Main text
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              height: screenSize.height * 0.15,
              child: FittedBox(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, size: 10),
                          Text(
                            'Olá ${option.username}',
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
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
                child: FittedBox(
                  child: Row(
                    children: const [
                      Icon(Icons.category),
                      SizedBox(width: 5),
                      Text('Categorias'),
                    ],
                  ),
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
                child: FittedBox(
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      SizedBox(width: 5),
                      Text('Perfil'),
                    ],
                  ),
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
                child: FittedBox(
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 5),
                      Text('Configurações'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
