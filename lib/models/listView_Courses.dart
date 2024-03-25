class Product {
  String imageURL;
  String title;
  double price;
  String id;
  String instructorName;
  double rating;

  Product({
    required this.imageURL,
    required this.title,
    required this.price,
    required this.id,
    required this.instructorName,
    required this.rating,
  });
  static List<Product> parseProductsFromServer(dynamic serverData) {
    print('parseProductsFromServer $serverData');
    var results = serverData['data']?['results'];
    print('parseProductsFromServer5 $results');

    if (results != null && results is List) {
      print('parseProductsFromServer2');
      return results.map<Product>((productData) {
        print('parseProductsFromServer3');
        return Product(
          imageURL: productData['thumbnail'],
          title: productData['title'],
          price: (productData['price'] as num).toDouble(),
          id: productData['_id'],
          instructorName: productData['instructorName'],
          rating: (productData['ratingsAverage'] as num).toDouble(),
        );
      }).toList();
    } else {
      print('error parseProductsFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'Product(imageURL: $imageURL, title: $title, price: $price, id: $id, instructorName: $instructorName, rating: $rating)';
  }
}
