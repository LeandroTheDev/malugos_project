import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:mysql1/mysql1.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        if (error.contains('1062')) {
          print('Erro o email já existe.');
        }
        print(error);
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                color: Colors.lightGreen,
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    Spacer(),
                    Text('Clique para logar'),
                    ElevatedButton(
                      onPressed: mysqlconnect,
                      child: Text('Logar'),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
