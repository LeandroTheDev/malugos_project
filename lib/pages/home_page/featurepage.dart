import 'package:flutter/material.dart';
import 'package:malugos_project/data/productsdata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';
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
    final optionsW = Provider.of<Options>(context, listen: true);

    Future pushProducts([id, category]) async {
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
      await mysql.close();
      return data;
    }

    Future pushCategory([id]) async {
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
      List<String> data = ['Tudo'];
      for (id; id <= lenght; id++) {
        dynamic category = await mysql
            .query('select category from products where id = ?', [id]);
        category = category.toString().replaceFirst('(Fields: {category: ', '');
        category = category.substring(0, category.length - 2);
        if (!data.contains(category)) {
          data.add(category);
        }
        //Jump the limiter
        if (id == lenght && id <= 10) {
          id = 10;
          lenght = 10 + lenght2;
        }
      }
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Destaques'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          //Category button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                //Category text
                const Text('Categoria:  '),
                //Select Category
                FutureBuilder(
                    future: pushCategory(1),
                    builder: (context, future) {
                      if (future.data == null) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            onChanged: (String? newValue) {
                              optionsW.changeFeatureCategory(newValue!);
                            },
                            value: optionsW.featureCategory,
                            items: future.data.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
          const Spacer(),
          //Show features products
          FutureBuilder(
              future: pushProducts(1, optionsW.featureCategory),
              builder: (context, future) {
                if (future.data == null) {
                  return Container(
                      alignment: Alignment.center,
                      width: screenSize.width,
                      height: 300,
                      child: const SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator()));
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.74,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        child: GridView.builder(
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
                                              name: future.data[index].name,
                                              description: future
                                                  .data[index].description,
                                              price: future.data[index].price,
                                              imageURL:
                                                  future.data[index].imageURL,
                                              nameFull:
                                                  future.data[index].nameFull,
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
                    ),
                  );
                }
              }),
          const Spacer(),
        ],
      ),
    );
  }
}

//On click show Feature Products
class FeatureProducts extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String imageURL;
  final String nameFull;

  const FeatureProducts({
    super.key,
    this.name = '',
    this.description = '',
    this.price = 0,
    this.imageURL = '',
    this.nameFull = '',
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Full name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  nameFull,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            //Image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: screenSize.height * 0.45,
                width: double.infinity,
                child: Image.network(imageURL),
              ),
            ),
            //Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: screenSize.width * 0.90,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(206, 171, 207, 171),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(description),
              ),
            ),
            //"Adicionar ao carrinho"
            ElevatedButton(
                onPressed: () {}, child: const Text('Adicionar ao Carrinho')),
            const SizedBox(height: 25),
            //"Ver no Site"
            ElevatedButton(onPressed: () {}, child: const Text('Ver no Site')),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
