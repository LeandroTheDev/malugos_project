import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';

class AuthRemember extends StatefulWidget {
  const AuthRemember({super.key});

  @override
  State<AuthRemember> createState() => _AuthRememberState();
}

class _AuthRememberState extends State<AuthRemember> {
  String email = '';
  String password = '';
  String username = '';
  int id = 0;
  bool remember = false;
//Starting the page
  @override
  //Starting
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
        //Error treatment
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text(':('),
                content: Text('Não foi possivel conectar ao servidor'),
              );
            });
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed('/authpage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
