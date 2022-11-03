import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:mysql1/mysql1.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    //Start Login
    mysqlconnect() async {
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      try {
        var result = await mysql.query(
          'insert into usuarios (email, password) values (?, ?)',
          ['bob@bob.com', 'password'],
        );
      } catch (result) {
        final String error = result.toString();
        //Erro email já existe
        if (error.contains('1062')) {
          print('Erro o email já existe.');
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lightGreen,
          ),
          Column(
            children: [
              //Entrar text
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: const [
                    Spacer(),
                    Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              //Login Scene
              SizedBox(
                width: screenSize.width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Email Text
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Email Input
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 144, 207, 71),
                        ),
                        height: 30,
                        width: screenSize.width * 0.85,
                        child: const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(14),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                            hintText: 'E-mail',
                          ),
                        ),
                      ),
                    ),
                    //Senha Text
                    const Text(
                      'Senha',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Senha Input
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 144, 207, 71),
                        ),
                        height: 30,
                        width: screenSize.width * 0.85,
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(14),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                            hintText: 'Senha',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
