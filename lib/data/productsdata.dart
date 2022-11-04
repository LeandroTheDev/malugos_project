import 'package:mysql1/mysql1.dart';
import 'mysqldata.dart';

class Product {
  static Future mysqlconnect() async {
    //Start Connection with DataBase
    final mysql = await MySqlConnection.connect(
      ConnectionSettings(
        host: MySqlData.adress,
        port: MySqlData.port,
        user: MySqlData.username,
        db: MySqlData.data,
        password: MySqlData.password,
      ),
    );
  }

  final String name;
  final String nameFull;
  final String description;
  final double price;
  final String imageURL;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.nameFull = '',
    this.imageURL = '',
  });
}

final dummyproducts = [
  Product(
    name: 'Computador Intel Core I5',
    nameFull:
        'COMPUTADOR MALUGOS GAMING , INTEL CORE I5-12400, NVIDIA GEFORCE GTX1660 6GB, 8GB DDR4, SSD 240GB',
    description: 'Computador gamer da malugos',
    price: 812.24,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
  Product(
    name: 'Teclado Gamer',
    description: 'Teclado Gamer da malugos RGB',
    price: 201.10,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Teclado-Mec-nico-Gamer-Redragon-Dark-Avenger-RGB-Switch-Red-PT-Com-Fio-K568-2_1639503116_gg.jpg',
  ),
  Product(
    name: 'Mouse Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 212.32,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/mouse-gamer-redragon-cobra-rgb-7-botoes-10000dpi-lunar-white-m711w_1600284702_gg.jpg',
  ),
  Product(
    name: 'MousePad Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 103.15,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/92982_index_gg.jpg',
  ),
];
