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
    final emailSave = TextEditingController();
    final passwordSave = TextEditingController();

    //Start Login
    Future<bool> mysqlconnect() async {
      //Start Connection with DataBase
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      int id = 0;

      //Test if credentials will Match
      while (true) {
        id++;
        var results = await mysql
            .query('select email, password from users where id = ?', [id]);
        //Verify if Email is valid
        if (emailSave.text.length < 4) {
          await mysql.close();
          return false;
        }
        if (!emailSave.text.contains('@')) {
          await mysql.close();
          return false;
        }
        //Verify if Table finish
        if (results.isEmpty) {
          await mysql.close();
          return false;
        }
        //Verify if Email and Password Matchs
        if (results.toString().contains(emailSave.text)) {
          if (results.toString().contains(passwordSave.text)) {
            dynamic username = await mysql
                .query('select username from users where id = ?', [id]);
            username =
                username.toString().replaceFirst('(Fields: {username: ', '');
            username = username.substring(0, username.length - 2);
            options.changeUserName(username);
            options.changeUserEmail(emailSave.text);
            options.changeUserPassword(passwordSave.text);
            options.changeCredentialsMatch();
            await mysql.close();
            return true;
          }
        }
      }
    }

    //Finish Login
    Future authProcess() async {
      await mysqlconnect();

      if (options.credentials) {
        // ignore: use_build_context_synchronously
        return Navigator.of(context).pushReplacementNamed('/homepage');
      } else {
        return const AlertDialog();
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
                          child: TextField(
                            controller: emailSave,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
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
                          child: TextField(
                            controller: passwordSave,
                            obscureText: true,
                            decoration: const InputDecoration(
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
                    const SizedBox(height: 20),
                    //Login Button
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        //Button Color
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 144, 207, 71),
                        ),
                        onPressed: () => authProcess(),
                        //Button Text
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 20,
                          width: screenSize.width * 0.7,
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(letterSpacing: 2),
                          ),
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
