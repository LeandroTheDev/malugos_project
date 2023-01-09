import 'package:flutter/material.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:malugos_project/data/productsdata.dart';
import '../data/mysqldata.dart';

class ProductItemSearch extends StatelessWidget {
  final String searchItem;
  const ProductItemSearch(this.searchItem, {super.key});

  @override
  Widget build(BuildContext context) {
    //Push the products based in search text
    Future<List<Product>> pushContainsProducts() async {
      List<Product> dataTemplate = [];
      List<Product> data = [];
      dataTemplate = await MySqlData.pushProducts();
      for (int i = 0; i <= dataTemplate.length - 1; i++) {
        bool pass = false;
        List<String> search = searchItem.split(' ');
        List<String> searchData = dataTemplate[i].nameFull.split(' ');
        for (int a = 0; a <= searchData.length - 1; a++) {
          for (int b = 0; b <= search.length - 1; b++) {
            if (searchData[a].toLowerCase().contains(search[b].toLowerCase())) {
              pass = true;
            }
          }
        }
        if (pass) {
          data.add(dataTemplate[i]);
        }
      }
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa: $searchItem'),
      ),
      body: FutureBuilder(
        future: pushContainsProducts(),
        builder: (context, future) {
          if (future.hasData) {
            if (future.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Ops não encontramos nada',
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              itemCount: future.data?.length,
              itemBuilder: (context, i) => FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeatureProducts(
                                  id: future.data![i].id,
                                  name: future.data![i].name,
                                  description: future.data![i].description,
                                  price: future.data![i].price,
                                  imageURL: future.data![i].imageURL,
                                  nameFull: future.data![i].nameFull,
                                  productLink: future.data![i].productURL,
                                )),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            //Product name
                            Text(
                              future.data![i].nameFull,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 7, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            //Image and price
                            Row(
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Image.network(
                                        future.data![i].imageURL)),
                                const SizedBox(width: 5),
                                Column(
                                  children: [
                                    const Text(
                                      'Preço:',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    Text(
                                      future.data![i].price.toString(),
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
