import 'package:flutter/material.dart';
import 'package:malugos_project/components/productitem_show.dart';
import '../../components/productitem_v.dart';
import '../../data/mysqldata.dart';

//Feature Page
class MostSellPage extends StatefulWidget {
  const MostSellPage({super.key});

  @override
  State<MostSellPage> createState() => _MostSellPageState();
}

class _MostSellPageState extends State<MostSellPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenSizeHeight = screenSize.height - kBottomNavigationBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais Vendidos'),
      ),
      body: Column(
        children: [
          //Show features products
          FutureBuilder(
              future: MySqlData.pushProducts(
                id: 1,
                isPromo: false,
                isHorizontal: false,
                isMostSell: true,
              ),
              builder: (context, future) {
                if (future.data == null) {
                  return Container(
                      alignment: Alignment.center,
                      width: screenSize.width,
                      height: screenSizeHeight,
                      child: const SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator()));
                } else {
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSizeHeight,
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
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
