import 'package:malugos_project/data/provider.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';

class MySqlData {
  static String username = 'guest';
  static String adress = 'localhost';
  static int port = 3306;
  static String data = 'malugos';
  static String password = '';

  //Returns the features Horizontal Length
  static Future<int> featureLenghtH(id) async {
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
    while (true) {
      var idData =
          await mysql.query('select id from products where id = ?', [id]);
      if (idData.toString() == '()' || id == 10) {
        id--;
        return id;
      }
      id++;
    }
  }

  //Returns the features Vertical Length
  static Future<int> featureLenghtV(id) async {
    int result = 0;
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
    while (true) {
      var idData =
          await mysql.query('select id from products where id = ?', [id]);
      if (idData.toString() == '()' && id <= 10) {
        break;
      }
      if (idData.toString() == '()' && id > 10) {
        break;
      }
      id++;
      result++;
    }
    return result;
  }

  //Update the providers from the database
  static Future updateProfileDatas([id, context]) async {
    final options = Provider.of<Options>(context, listen: false);
    final mysql = await MySqlConnection.connect(
      ConnectionSettings(
        host: MySqlData.adress,
        port: MySqlData.port,
        user: MySqlData.username,
        db: MySqlData.data,
        password: MySqlData.password,
      ),
    );
  }
}
