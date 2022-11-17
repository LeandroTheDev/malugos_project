import 'dart:async';

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
  String email = '';
  String password = '';
  String username = '';
  int id = 0;
  bool remember = false;
  bool jumpAuth = false;
  //Starting the page
  @override
  void initState() {
    super.initState();
    //Load datas
    email = UserPreferences.getEmail() ?? '';
    password = UserPreferences.getPassword() ?? '';
    username = UserPreferences.getUsername() ?? '';
    id = UserPreferences.getId() ?? 0;
    remember = UserPreferences.getRemember() ?? false;
    //check if credentials matchs
    if (remember) {
      // ignore: unused_local_variable
      Future mysql = MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      ).then((mysql) async {
        dynamic checkEmail =
            await mysql.query('select email from users where id = ?', [id]);
        checkEmail =
            checkEmail.toString().replaceFirst('(Fields: {email: ', '');
        checkEmail = checkEmail.substring(0, checkEmail.length - 2);
        //pickup password
        dynamic checkPassword =
            await mysql.query('select password from users where id = ?', [id]);
        checkPassword =
            checkPassword.toString().replaceFirst('(Fields: {password: ', '');
        checkPassword = checkPassword.substring(0, checkPassword.length - 2);

        if (email == checkEmail) {
          if (password == checkPassword) {
            // ignore: use_build_context_synchronously
            final options = Provider.of<Options>(context, listen: false);
            //Add in the provider all informations
            options.changeUserEmail(email);
            options.changeUserPassword(password);
            options.changeUserName(username);
            options.changeId(id);
            options.changeRememberLogin();
            options.changeCredentialsMatch();
            Future(
              () => Navigator.of(context).pushReplacementNamed('/homepage'),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final options = Provider.of<Options>(context, listen: false);
    final optionsW = Provider.of<Options>(context, listen: true);
    String errorMsg = 'Erro Desconhecido';

    //Start Login
    Future<bool> mysqlconnect() async {
      //Start Connection with DataBase
      MySqlConnection mysql = await MySqlConnection.connect(
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
        //pickup email
        dynamic email =
            await mysql.query('select email from users where id = ?', [id]);
        email = email.toString().replaceFirst('(Fields: {email: ', '');
        email = email.substring(0, email.length - 2);
        //pickup password
        dynamic password =
            await mysql.query('select password from users where id = ?', [id]);
        password = password.toString().replaceFirst('(Fields: {password: ', '');
        password = password.substring(0, password.length - 2);
        //Verify if Email is valid
        if (options.emailLogin.text.length < 4) {
          await mysql.close();
          errorMsg = 'Ops, E-mail ou senha inválidos';
          return false;
        }
        if (!options.emailLogin.text.contains('@')) {
          await mysql.close();
          errorMsg = 'Ops, E-mail ou senha inválidos';
          return false;
        }
        //Verify if Table finish
        if (email == '') {
          await mysql.close();
          errorMsg = 'Ops, E-mail ou senha inválidos';
          return false;
        }
        //Verify if Email and Password Matchs
        if (email == options.emailLogin.text) {
          if (password == options.passwordLogin.text) {
            dynamic username = await mysql
                .query('select username from users where id = ?', [id]);
            username =
                username.toString().replaceFirst('(Fields: {username: ', '');
            username = username.substring(0, username.length - 2);
            //Add in the provider all informations
            options.changeUserEmail(email);
            options.changeUserPassword(password);
            options.changeUserName(username);
            options.changeId(id);
            options.changeCredentialsMatch();
            //Create the userdata on database
            try {
              await mysql.query('insert into userdata (id) values (?)', [id]);
              options.changeId(id);
              await mysql.close();
              return true;
            } catch (error) {
              if (error.toString().contains('1062')) {
                options.changeId(id);
                await mysql.close();
                return true;
              } else {
                await mysql.close();
                errorMsg =
                    'Ops aconteceu um erro na hora de confirmar sua identidade';
                return false;
              }
            }
          }
        }
      }
    }

    //Finish Login
    Future authProcess() async {
      bool credentials = await mysqlconnect();
      if (!credentials) {
        optionsW.changeIsLoading();
      }
      if (credentials) {
        if (options.rememberLogin) {
          UserPreferences.setEmail(options.email);
          UserPreferences.setPassword(options.password);
          UserPreferences.setUsername(options.username);
          UserPreferences.setRemember(options.rememberLogin);
        }
        // ignore: use_build_context_synchronously
        return Navigator.of(context).pushReplacementNamed('/homepage');
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(':('),
                content: Text(errorMsg),
              );
            });
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
                          child: TextFormField(
                            controller: options.emailLogin,
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
                          child: TextFormField(
                            controller: options.passwordLogin,
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
                    const SizedBox(height: 10),
                    //Remember
                    Row(
                      children: [
                        Checkbox(
                          value: options.rememberLogin,
                          fillColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          checkColor: Colors.lightGreen,
                          onChanged: (_) {
                            optionsW.changeRememberLogin();
                          },
                        ),
                        const Text(
                          'Lembrar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    //Login Button
                    Container(
                      alignment: Alignment.center,
                      child: options.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : ElevatedButton(
                              //Button Color
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 144, 207, 71),
                              ),
                              onPressed: () {
                                optionsW.changeIsLoading();
                                authProcess();
                              },
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
