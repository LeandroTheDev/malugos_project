import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:malugos_project/components/drawer.dart';
import 'package:malugos_project/components/drawershop.dart';
import 'package:malugos_project/components/productitem_h.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:mysql1/mysql1.dart';
import '../data/mysqldata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Connect to the database and push Products Info
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
      int lenght = await MySqlData.featureLenghtH(id);
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
      }
      await mysql.close();
      return data;
    }

    //Connect to the database and push Images url
    Future pushImages() async {
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

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //Drawers
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: const AppDrawer(),
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.lightGreen,
        ),
        child: const DrawerShop(),
      ),
      //AppBar
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.shopping_bag_outlined),
            );
          }),
        ],
        title: SizedBox(
          child: SizedBox(
            height: 65,
            child: Image.asset("assets/malugosicon.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            //"Destaques"
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/featurepage');
              },
              child: Container(
                width: screenSize.width * 0.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.shopping_cart,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Destaques',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Features Horizontal View
            FutureBuilder(
              future: pushProducts(1),
              builder: (BuildContext context, future) {
                if (future.data == null) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeatureProducts(
                                            id: future.data[i].id,
                                            name: future.data[i].name,
                                            description:
                                                future.data[i].description,
                                            price: future.data[i].price,
                                            imageURL: future.data[i].imageURL,
                                            nameFull: future.data[i].nameFull,
                                            productLink:
                                                future.data[i].productURL,
                                          )),
                                );
                              },
                              child: ProductItemH(
                                future.data[i].name,
                                future.data[i].price,
                                future.data[i].imageURL,
                                screenSize.width,
                                screenSize.height * 0.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            //"Mais Vendidos"
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mostsellpage');
              },
              child: Container(
                width: screenSize.width * 0.45,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.shop,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mais Vendidos',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Images
            FutureBuilder(
                future: pushImages(),
                builder: (context, future) {
                  if (future.data == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return TextButton(
                      onPressed: () {},
                      child: SizedBox(
                        width: screenSize.width,
                        height: 200,
                        child: CarouselSlider.builder(
                          itemCount: future.data.length,
                          options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3)),
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              color: Colors.lightGreen,
                              child: Image.network(future.data[index]),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            //"Promoção"
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/promopage');
              },
              child: Container(
                width: screenSize.width * 0.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.sell_outlined,
                          color: Color.fromARGB(255, 56, 56, 56),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Promoção',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Promotions Horizontal View
            FutureBuilder(
              future: MySqlData.pushProducts(
                id: 1,
                isPromo: true,
                isHorizontal: true,
                isMostSell: false,
              ),
              builder: (BuildContext context, future) {
                if (future.data == null) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: future.data.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeatureProducts(
                                            id: future.data[i].id,
                                            name: future.data[i].name,
                                            description:
                                                future.data[i].description,
                                            price: future.data[i].price,
                                            imageURL: future.data[i].imageURL,
                                            nameFull: future.data[i].nameFull,
                                            productLink:
                                                future.data[i].productURL,
                                          )),
                                );
                              },
                              child: ProductItemH(
                                future.data[i].name,
                                future.data[i].price,
                                future.data[i].imageURL,
                                screenSize.width,
                                screenSize.height * 0.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
