import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';

import '../data/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final options = Provider.of<Options>(context, listen: false);
    final optionsW = Provider.of<Options>(context);

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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //Background Color
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lightGreen,
          ),
          Column(
            children: [
              //Malugos Image
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: screenSize.height * 0.15,
                  width: double.infinity,
                  child: Image.asset("assets/malugosicon.png"),
                ),
              ),
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
                        height: 40,
                        width: screenSize.width * 0.85,
                        child: SizedBox(
                          height: 33,
                          width: screenSize.width * 0.85,
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              hintText: 'E-mail',
                            ),
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
                        height: 40,
                        width: screenSize.width * 0.85,
                        child: SizedBox(
                          height: 33,
                          width: screenSize.width * 0.85,
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Remember Informations
                    Row(
                      children: [
                        Checkbox(
                          value: optionsW.rememberMe,
                          onChanged: (value) {
                            options.changeRememberMe();
                            print(options.rememberMe);
                          },
                          fillColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              checkColor: Colors.white,
                        ),
                        const Text(
                          'Lembrar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 49, 49, 49),
                          ),
                        )
                      ],
                    ),
                    //Login Button
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 144, 207, 71),
                        ),
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 20,
                          width: screenSize.width * 0.7,
                          child: Text('Login'),
                        ),
                      ),
                    )
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
