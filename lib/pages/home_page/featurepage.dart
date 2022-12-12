import 'package:flutter/material.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:mysql1/mysql1.dart';
import '../../components/productitem_v.dart';
import '../../data/mysqldata.dart';

//Feature Page
class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenSizeHeight = screenSize.height - kBottomNavigationBarHeight;

    //Connection to the database and push products
    Future pushProducts([id]) async {
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
        if (id == lenght && id <= 10) {
          id = 10;
          lenght = 10 + lenght2;
        }
      }
      await mysql.close();
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Destaques'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            //Show features products
            FutureBuilder(
                future: pushProducts(1),
                builder: (context, future) {
                  if (future.data == null) {
                    return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemCount: future.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FeatureProducts(
                                              id: future.data[index].id,
                                              name: future.data[index].name,
                                              description: future
                                                  .data[index].description,
                                              price: future.data[index].price,
                                              imageURL:
                                                  future.data[index].imageURL,
                                              nameFull:
                                                  future.data[index].nameFull,
                                              productLink:
                                                  future.data[index].productURL,
                                            )),
                                  );
                                },
                                child: ProductItemV(
                                  future.data[index].name,
                                  future.data[index].price,
                                  future.data[index].imageURL,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
