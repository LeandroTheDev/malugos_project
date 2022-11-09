import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = Provider.of<Options>(context, listen: true);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.2,
              child: const CircleAvatar(
                backgroundColor: Colors.lightGreen,
              ),
            ),
          ),
          Text(
            options.username,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    '1000,00 R\$',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      '0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
                Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      '0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: const Text(
                  'Créditos',
                ),
              ),
              const Spacer(),
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: const Text(
                    'A Caminho',
                  )),
              const Spacer(),
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: const Text(
                    'Pontos',
                  )),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightGreen),
                child: SizedBox(
                  width: screenSize.width,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
