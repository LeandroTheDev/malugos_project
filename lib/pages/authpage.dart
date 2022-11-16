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
  String username = '';
  String password = '';
  bool remember = false;
  //Starting the page
  @override
  void initState() {
    super.initState();
    //Load datas
    username = UserPreferences.getUsername() ?? '';
    password = UserPreferences.getPassword() ?? '';
    remember = UserPreferences.getRemember() ?? false;
    if (remember) {}
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
      MySqlConnection mysql;
      //Error treatment for conections
      try {
        mysql = await MySqlConnection.connect(
          ConnectionSettings(
            host: MySqlData.adress,
            port: MySqlData.port,
            user: MySqlData.username,
            db: MySqlData.data,
            password: MySqlData.password,
          ),
        );
      } catch (error) {
        if (error.toString().contains('1225')) {
          errorMsg = 'Ops o servidor parece estar Offline';
          username = UserPreferences.getUsername().toString();
          password = UserPreferences.getPassword().toString();
          remember = UserPreferences.getRemember() as bool;
          return false;
        } else {
          errorMsg = 'Erro Desconhecido';
          return false;
        }
      }
      int id = 0;

      //Test if credentials will Match
      while (true) {
        id++;
        var results = await mysql
            .query('select email, password from users where id = ?', [id]);
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
        if (results.isEmpty) {
          await mysql.close();
          errorMsg = 'Ops, E-mail ou senha inválidos';
          return false;
        }
        //Verify if Email and Password Matchs
        if (results.toString().contains(options.emailLogin.text)) {
          if (results.toString().contains(options.passwordLogin.text)) {
            dynamic username = await mysql
                .query('select username from users where id = ?', [id]);
            username =
                username.toString().replaceFirst('(Fields: {username: ', '');
            username = username.substring(0, username.length - 2);
            //Add in the provider all informations
            options.changeUserName(username);
            options.changeUserEmail(options.emailLogin.text);
            options.changeUserPassword(options.passwordLogin.text);
            options.changeCredentialsMatch();
            //Create the userdata on database
            try {
              await mysql.query('insert into userdata (id) values (?)', [id]);
              options.changeId(id);
              await mysql.close();
              return true;
            } catch (error) {
              if (error.toString().contains('Duplicate entry')) {
                options.changeId(id);
                await mysql.close();
                return true;
              } else {
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
          UserPreferences.setUsername(options.username);
          UserPreferences.setPassword(options.password);
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
