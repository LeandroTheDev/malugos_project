import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = Provider.of<Options>(context, listen: true);
    final profileData = Provider.of<Options>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          //Avatar image
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
          //Name
          Text(
            options.username,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          //First Row informations
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  //Credits number
                  child: Text(
                    '${profileData.credits.toStringAsFixed(2)} R\$',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                //Orders
                Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      profileData.onWay.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
                //Points number
                Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      profileData.points.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
              ],
            ),
          ),
          //Second Row informations
          Row(
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: 100,
                //Credits text
                child: const Text(
                  'Créditos',
                ),
              ),
              const Spacer(),
              //On the way
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: const Text(
                    'A Caminho',
                  )),
              const Spacer(),
              //Points text
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
          //Profile infos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightGreen),
                child: SizedBox(
                  width: screenSize.width,
                  //Account Details
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //History
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {},
                              //"Historico"
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          52, 255, 255, 255),
                                    ),
                                    child: const Icon(
                                      Icons.history,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Histórico',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //Details
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextButton(
                            onPressed: () {},
                            //"Detalhes"
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(52, 255, 255, 255),
                                  ),
                                  child: const Icon(
                                    Icons.settings,
                                    color: Colors.black,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'Detalhes',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Order Location
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {},
                              //"Historico"
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          52, 255, 255, 255),
                                    ),
                                    child: const Icon(
                                      Icons.add_home_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Locais de Entrega',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        //Logout
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                UserPreferences.setRemember(false);
                                Navigator.pushReplacementNamed(
                                    context, '/authpage');
                              },
                              //"Historico"
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          52, 255, 255, 255),
                                    ),
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Sair',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
