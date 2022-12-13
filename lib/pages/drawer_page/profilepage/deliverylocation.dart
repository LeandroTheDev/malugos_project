import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:provider/provider.dart';
import '../../../data/mysqldata.dart';
import '../../../data/provider.dart';

class DeliveryLocation extends StatefulWidget {
  const DeliveryLocation({super.key});

  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends State<DeliveryLocation> {
  @override
  Widget build(BuildContext context) {
    final option = Provider.of<Options>(context, listen: false);

    //Push items in delivery mysql
    Future<Map<String, dynamic>> pushDelivery() async {
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
          .query('select delivery from userdata where id = ?', [option.id]);
      results = results.toString().replaceFirst('(Fields: {delivery: ', '');
      results = results.substring(0, results.length - 2);
      Map<String, dynamic> data = jsonDecode(results);
      await mysql.close();
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locais de Entrega'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Add delivery button
              FittedBox(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(Icons.add_home_outlined),
                        SizedBox(width: 10),
                        Text('Adicionar Lugar'),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Delivery locations
              FutureBuilder(
                  future: pushDelivery(),
                  builder: (context, future) {
                    if (future.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: future.data!.length,
                        itemBuilder: (context, i) {
                          return FittedBox(
                            child: Container(
                              width: 240,
                              height: 246,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Road name
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                        right: 1,
                                      ),
                                      child: SizedBox(
                                        height: 45,
                                        child: Text(
                                          'Rua: ${future.data!['Delivery$i']['roadName']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    //House number
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                      ),
                                      child: SizedBox(
                                        height: 25,
                                        child: Text(
                                          'Numero: ${future.data!['Delivery$i']['houseNumber']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    //State
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                      ),
                                      child: SizedBox(
                                        height: 25,
                                        child: Text(
                                          'Estado: ${future.data!['Delivery$i']['state']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    //District
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                      ),
                                      child: SizedBox(
                                        height: 25,
                                        child: Text(
                                          'Bairro: ${future.data!['Delivery$i']['district']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    //CEP
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                      ),
                                      child: SizedBox(
                                        height: 25,
                                        child: Text(
                                          'CEP: ${future.data!['Delivery$i']['CEP']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    //Contact number
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 2,
                                      ),
                                      child: SizedBox(
                                        height: 45,
                                        child: Text(
                                          'Numero de contato: ${future.data!['Delivery$i']['contactNumber']}',
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    //Remove Location
                                    Row(
                                      children: [
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Remover Local'),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      //Loading
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
