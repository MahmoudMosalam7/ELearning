class EnrolledCourses {
  String imageURL;
  String title;
  String id;
  String instructorName;
  double progress;

  EnrolledCourses({
    required this.imageURL,
    required this.title,
    required this.id,
    required this.instructorName,
    required this.progress,
  });
  static List<EnrolledCourses> parseProductsFromServer(dynamic serverData) {
    print('parseProductsFromServer ${serverData['data']?['results']}');
    var results = serverData['data']?['resutls'];
    print('parseProductsFromServer5 $results');

   if (results != null && results is List) {
      print('parseProductsFromServer2');
      return results.map<EnrolledCourses>((productData) {
        print('parseProductsFromServer3 $productData');
        return EnrolledCourses(
          imageURL: productData['thumbnail'],
          title: productData['title'],
          id: productData['_id'],
          instructorName: productData['instructor'],
          progress: (productData['progress'] as num).toDouble(),
        );
      }).toList();
    } else {
      print('error parseProductsFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'Product(imageURL: $imageURL, title: $title,  id: $id, instructorName: $instructorName, progress: $progress)';
  }
}
