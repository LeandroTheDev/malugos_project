import 'package:flutter/material.dart';
import 'package:malugos_project/components/productitem_show.dart';
import 'package:malugos_project/components/productitem_v.dart';
import 'package:malugos_project/data/mysqldata.dart';

class MonitorCategory extends StatelessWidget {
  const MonitorCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitores'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Products
          FutureBuilder(
            future: MySqlData.pushCategoryItem(id: 1, category: 'Monitor'),
            builder: ((context, future) {
              if (future.hasData) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: future.data!.length,
                      itemBuilder: ((context, index) {
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
                                          name: future.data![index].name,
                                          description:
                                              future.data![index].description,
                                          price: future.data![index].price,
                                          imageURL:
                                              future.data![index].imageURL,
                                          nameFull:
                                              future.data![index].nameFull,
                                        )),
                              );
                            },
                            child: ProductItemV(
                              future.data![index].name,
                              future.data![index].price,
                              future.data![index].imageURL,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
