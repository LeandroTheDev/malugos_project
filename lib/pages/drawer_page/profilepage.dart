import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final options = Provider.of<Options>(context, listen: true);
    final profileData = Provider.of<Options>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                options.username,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  //First Row informations
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          width: screenSize.width * 0.3,
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
                            width: screenSize.width * 0.3,
                            child: Text(
                              profileData.onWay.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                        const Spacer(),
                        //Points number
                        Container(
                            alignment: Alignment.center,
                            width: screenSize.width * 0.3,
                            child: Text(
                              profileData.points.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                        const Spacer(),
                      ],
                    ),
                  ),
                  //Second Row informations
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          width: screenSize.width * 0.3,
                          //Credits text
                          child: const Text(
                            'Créditos',
                          ),
                        ),
                        const Spacer(),
                        //On the way
                        Container(
                            alignment: Alignment.center,
                            width: screenSize.width * 0.3,
                            child: const Text(
                              'A Caminho',
                            )),
                        const Spacer(),
                        //Points text
                        Container(
                            alignment: Alignment.center,
                            width: screenSize.width * 0.3,
                            child: const Text(
                              'Pontos',
                            )),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //Profile infos
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightGreen),
                child: SizedBox(
                  width: screenSize.width,
                  height: 260,
                  //Account Details
                  child: Column(
                    children: [
                      //History
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: screenSize.width,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/history');
                            },
                            //"Historico"
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
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
                        ),
                      ),
                      //Details
                      SizedBox(
                        width: screenSize.width,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/details');
                          },
                          //"Detalhes"
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
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
                                      Icons.settings,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Detalhes',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Order Location
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: screenSize.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/deliverylocation');
                            },
                            //"Locais de Entrega"
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
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
                        ),
                      ),
                      const Divider(),
                      //Logout
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: screenSize.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              UserPreferences.setRemember(false);
                              options.changeEmailLogin(TextEditingController());
                              options
                                  .changePasswordLogin(TextEditingController());
                              options.changeRememberLogin();
                              Navigator.pushReplacementNamed(
                                  context, '/authpage');
                            },
                            //"Exit"
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
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
                          ),
                        ),
                      )
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
