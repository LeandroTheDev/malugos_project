import 'package:malugos_project/data/productsdata.dart';
import 'package:mysql1/mysql1.dart';

class MySqlData {
  static String username = 'admin';
  static String adress = 'localhost';
  static int port = 3306;
  static String data = 'malugos';
  static String password = 'password';

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

  //Returns selected category items
  static Future<List<Product>> pushCategoryItem([id]) async {
    int id = 1;
    //Estabilish connection
    final mysql = await MySqlConnection.connect(
      ConnectionSettings(
        host: MySqlData.adress,
        port: MySqlData.port,
        user: MySqlData.username,
        db: MySqlData.data,
        password: MySqlData.password,
      ),
    );
    //Pick lenght of table products
    int lenght = await featureLenghtV(id);
    int lenght2 = await featureLenghtV(11);
    List<Product> data = [];
    for (id; id <= lenght; id++) {
      //Take the informations from database
      dynamic name =
          await mysql.query('select name from products where id = ?', [id]);
      name = name.toString().replaceFirst('(Fields: {name: ', '');
      name = name.substring(0, name.length - 2);
      dynamic price =
          await mysql.query('select price from products where id = ?', [id]);
      price = price.toString().replaceFirst('(Fields: {price: ', '');
      price = price.substring(0, price.length - 2);
      price = double.parse(price);
      dynamic imageURL =
          await mysql.query('select imageURL from products where id = ?', [id]);
      imageURL = imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
      imageURL = imageURL.substring(0, imageURL.length - 2);
      dynamic description = await mysql
          .query('select description from products where id = ?', [id]);
      description =
          description.toString().replaceFirst('(Fields: {description: ', '');
      description = description.substring(0, description.length - 2);
      dynamic nameFull =
          await mysql.query('select nameFULL from products where id = ?', [id]);
      nameFull = nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
      nameFull = nameFull.substring(0, nameFull.length - 2);
      //Repass the informations into variable
      Product productInfo = Product(
        id: id,
        name: name,
        description: description,
        price: price,
        imageURL: imageURL,
        nameFull: nameFull,
      );
      //Add informations into list
      data.add(productInfo);
      //Jump the limiter
      if (id == lenght && id <= 10) {
        id = 10;
        lenght = 10 + lenght2;
      }
    }
    return data;
  }
}
