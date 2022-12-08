class Product {
  final int id;
  final String name;
  final String nameFull;
  final String description;
  final double price;
  final String imageURL;
  final String category;
  final String productURL;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.nameFull = '',
    this.imageURL = '',
    this.category = '',
    required this.productURL,
  });
}

class HistoryItem {
  final int id;
  final String name;
  final double price;
  final String date;
  final String imageURL;

  HistoryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.date,
    required this.imageURL,
  });
}
