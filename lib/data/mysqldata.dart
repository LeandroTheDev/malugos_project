import 'package:mysql1/mysql1.dart';

class MySqlData {
  static String username = 'root';
  static String adress = 'localhost';
  static int port = 3306;
  static String data = 'malugos';
  static String password = 'password';
  static Future<int> featureLenght() async {
    final mysql = await MySqlConnection.connect(
      ConnectionSettings(
        host: MySqlData.adress,
        port: MySqlData.port,
        user: MySqlData.username,
        db: MySqlData.data,
        password: MySqlData.password,
      ),
    );
    //Verify if the table is finish
    int id = 0;
    while (true) {
      id++;
      var idData =
          await mysql.query('select id from products where id = ?', [id]);
      if (idData.toString() == '()') {
        id--;
        break;
      } else if (id >= 10) {
        break;
      }
    }
    return id;
  }
}
