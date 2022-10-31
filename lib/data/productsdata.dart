class Product {
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
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 812.24,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
  Product(
    name: 'Teclado Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 201.10,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
  Product(
    name: 'Mouse Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 212.32,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
  Product(
    name: 'MousePad RGB',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 103.15,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
  Product(
    name: 'Head Set Razer Gamer',
    description:
        'uma cadeira gamer descrição descrição descrição descrição descrição',
    price: 431.53,
    imageURL:
        'https://www.malugos.com.br/images/virtuemart/product/Prancheta%204.png',
  ),
];
