import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final option = Provider.of<Options>(context, listen: false);

    Future<Map<String, dynamic>> pushHistory() async {
      final mysql = await MySqlConnection.connect(
        ConnectionSettings(
          host: MySqlData.adress,
          port: MySqlData.port,
          user: MySqlData.username,
          db: MySqlData.data,
          password: MySqlData.password,
        ),
      );
      dynamic results = await mysql
          .query('select history from userdata where id = ?', [option.id]);
      results = results.toString().replaceFirst('(Fields: {history: ', '');
      results = results.substring(0, results.length - 2);
      Map<String, dynamic> data = jsonDecode(results);
      int i = 0;
      while (true) {
        if (data["Order$i"] == null) {
          break;
        }
        double totalPrice = 0;
        int a = 0;
        while (true) {
          if (data["Order$i"]["Product$a"] == null) {
            break;
          }
          totalPrice = totalPrice + data["Order$i"]["Product$a"]['price'];
        }
        data["Order$i"]["Product$a"]['totalPrice'] = totalPrice;
        i++;
      }
      await mysql.close();
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: pushHistory(),
              builder: (context, future) {
                if (future.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Preço: ${future.data!['Order$index']['Product0']['totalPrice']}",
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Data: ${future.data!['Order$index']['Product0']['data']}",
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    future.data![index].imageURL,
                                    scale: 0.3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircularProgressIndicator(),
                  ));
                }
              }),
        ],
      ),
    );
  }
}
