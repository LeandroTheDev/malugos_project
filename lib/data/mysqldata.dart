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

  //Returns the products
  static Future pushProducts({
    id = 1,
    bool isPromo = false,
    bool isMostSell = false,
    bool isHorizontal = false,
  }) async {
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
    int lenght = await MySqlData.featureLenghtV(id);
    int lenght2 = await MySqlData.featureLenghtV(11);
    List<Product> data = [];
    if (isPromo) {
      for (id; id <= lenght; id++) {
        dynamic isPromoDB = await mysql
            .query('select isPromo from products where id = ?', [id]);
        isPromoDB =
            isPromoDB.toString().replaceFirst('(Fields: {isPromo: ', '');
        isPromoDB = isPromoDB.substring(0, isPromoDB.length - 2);
        isPromoDB = isPromoDB == 'true';

        if (isPromoDB) {
          //Take the informations from database
          dynamic name =
              await mysql.query('select name from products where id = ?', [id]);
          name = name.toString().replaceFirst('(Fields: {name: ', '');
          name = name.substring(0, name.length - 2);
          dynamic price = await mysql
              .query('select price from products where id = ?', [id]);
          price = price.toString().replaceFirst('(Fields: {price: ', '');
          price = price.substring(0, price.length - 2);
          price = double.parse(price);
          dynamic imageURL = await mysql
              .query('select imageURL from products where id = ?', [id]);
          imageURL =
              imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
          imageURL = imageURL.substring(0, imageURL.length - 2);
          dynamic description = await mysql
              .query('select description from products where id = ?', [id]);
          description = description
              .toString()
              .replaceFirst('(Fields: {description: ', '');
          description = description.substring(0, description.length - 2);
          dynamic nameFull = await mysql
              .query('select nameFULL from products where id = ?', [id]);
          nameFull =
              nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
          nameFull = nameFull.substring(0, nameFull.length - 2);
          dynamic productURL = await mysql
              .query('select linkURL from products where id = ?', [id]);
          productURL =
              productURL.toString().replaceFirst('(Fields: {linkURL: ', '');
          productURL = productURL.substring(0, productURL.length - 2);
          //Repass the informations into variable
          Product productInfo = Product(
            id: id,
            name: name,
            description: description,
            price: price,
            imageURL: imageURL,
            nameFull: nameFull,
            productURL: productURL,
          );
          //Add informations into list
          data.add(productInfo);
          //Jump the limiter
          //Jump the limiter
          if (isHorizontal) {
            if (id == lenght && id <= 10) {
              id = 10;
              lenght = 10 + lenght2;
            }
            if (data.length > 6) {
              break;
            }
          }
        }
      }
    } else if (isMostSell) {
      for (id; id <= lenght; id++) {
        dynamic isMostSellDB = await mysql
            .query('select isMostSell from products where id = ?', [id]);
        isMostSellDB =
            isMostSellDB.toString().replaceFirst('(Fields: {isMostSell: ', '');
        isMostSellDB = isMostSellDB.substring(0, isMostSellDB.length - 2);
        isMostSellDB = isMostSellDB == 'true';

        if (isMostSellDB) {
          //Take the informations from database
          dynamic name =
              await mysql.query('select name from products where id = ?', [id]);
          name = name.toString().replaceFirst('(Fields: {name: ', '');
          name = name.substring(0, name.length - 2);
          dynamic price = await mysql
              .query('select price from products where id = ?', [id]);
          price = price.toString().replaceFirst('(Fields: {price: ', '');
          price = price.substring(0, price.length - 2);
          price = double.parse(price);
          dynamic imageURL = await mysql
              .query('select imageURL from products where id = ?', [id]);
          imageURL =
              imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
          imageURL = imageURL.substring(0, imageURL.length - 2);
          dynamic description = await mysql
              .query('select description from products where id = ?', [id]);
          description = description
              .toString()
              .replaceFirst('(Fields: {description: ', '');
          description = description.substring(0, description.length - 2);
          dynamic nameFull = await mysql
              .query('select nameFULL from products where id = ?', [id]);
          nameFull =
              nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
          nameFull = nameFull.substring(0, nameFull.length - 2);
          dynamic productURL = await mysql
              .query('select linkURL from products where id = ?', [id]);
          productURL =
              productURL.toString().replaceFirst('(Fields: {linkURL: ', '');
          productURL = productURL.substring(0, productURL.length - 2);
          //Repass the informations into variable
          Product productInfo = Product(
            id: id,
            name: name,
            description: description,
            price: price,
            imageURL: imageURL,
            nameFull: nameFull,
            productURL: productURL,
          );
          //Add informations into list
          data.add(productInfo);
          //Jump the limiter
          //Jump the limiter
          if (isHorizontal) {
            if (id == lenght && id <= 10) {
              id = 10;
              lenght = 10 + lenght2;
            }
            if (data.length > 6) {
              break;
            }
          }
        }
      }
    } else {
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
        dynamic imageURL = await mysql
            .query('select imageURL from products where id = ?', [id]);
        imageURL = imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
        imageURL = imageURL.substring(0, imageURL.length - 2);
        dynamic description = await mysql
            .query('select description from products where id = ?', [id]);
        description =
            description.toString().replaceFirst('(Fields: {description: ', '');
        description = description.substring(0, description.length - 2);
        dynamic nameFull = await mysql
            .query('select nameFULL from products where id = ?', [id]);
        nameFull = nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
        nameFull = nameFull.substring(0, nameFull.length - 2);
        dynamic productURL = await mysql
            .query('select linkURL from products where id = ?', [id]);
        productURL =
            productURL.toString().replaceFirst('(Fields: {linkURL: ', '');
        productURL = productURL.substring(0, productURL.length - 2);
        //Repass the informations into variable
        Product productInfo = Product(
          id: id,
          name: name,
          description: description,
          price: price,
          imageURL: imageURL,
          nameFull: nameFull,
          productURL: productURL,
        );
        //Add informations into list
        data.add(productInfo);
        //Jump the limiter
        if (isHorizontal) {
          if (id == lenght && id <= 10) {
            id = 10;
            lenght = 10 + lenght2;
          }
        }
      }
    }
    await mysql.close();
    return data;
  }

  //Returns selected category items
  static Future<List<Product>> pushCategoryItem(
      {id, String category = ''}) async {
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
    List<Product> data = [];
    //Pick lenght of table products
    int lenght = await MySqlData.featureLenghtV(id);
    int lenght2 = await MySqlData.featureLenghtV(11);
    //Take the informations from database
    for (id; id <= lenght; id++) {
      dynamic categorydb =
          await mysql.query('select category from products where id = ?', [id]);
      categorydb =
          categorydb.toString().replaceFirst('(Fields: {category: ', '');
      categorydb = categorydb.substring(0, categorydb.length - 2);
      //If product have the same category
      if (categorydb == category) {
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
        dynamic imageURL = await mysql
            .query('select imageURL from products where id = ?', [id]);
        imageURL = imageURL.toString().replaceFirst('(Fields: {imageURL: ', '');
        imageURL = imageURL.substring(0, imageURL.length - 2);
        dynamic description = await mysql
            .query('select description from products where id = ?', [id]);
        description =
            description.toString().replaceFirst('(Fields: {description: ', '');
        description = description.substring(0, description.length - 2);
        dynamic nameFull = await mysql
            .query('select nameFULL from products where id = ?', [id]);
        nameFull = nameFull.toString().replaceFirst('(Fields: {nameFULL: ', '');
        nameFull = nameFull.substring(0, nameFull.length - 2);
        dynamic productURL = await mysql
            .query('select linkURL from products where id = ?', [id]);
        productURL =
            productURL.toString().replaceFirst('(Fields: {linkURL: ', '');
        productURL = productURL.substring(0, productURL.length - 2);
        //Repass the informations into variable
        Product productInfo = Product(
          id: id,
          name: name,
          description: description,
          price: price,
          imageURL: imageURL,
          nameFull: nameFull,
          productURL: productURL,
        );
        //Add informations into list
        data.add(productInfo);
      }
      //Jump the limiter
      if (id == lenght && id <= 10) {
        id = 10;
        lenght = 10 + lenght2;
      }
    }
    await mysql.close();
    return data;
  }

  //Push carrousel images
  static Future pushImages() async {
    //Debug
    List<String> imageURL = [];
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
    int i = 1;
    while (true) {
      dynamic imageURLDB =
          await mysql.query('select imageURL from images where id = ?', [i]);
      imageURLDB =
          imageURLDB.toString().replaceFirst('(Fields: {imageURL: ', '');
      imageURLDB = imageURLDB.substring(0, imageURLDB.length - 2);
      if (imageURLDB == '') {
        break;
      }
      if (i >= 10) {
        break;
      }
      imageURL.add(imageURLDB);
      i++;
    }
    await mysql.close();
    return imageURL;
  }
}
