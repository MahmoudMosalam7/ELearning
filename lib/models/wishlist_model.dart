
class WishList {
  final String title;
  final String id;
  final String imageUrl;
  final String instructorName;
  final String priceCurrency;
  final String priceAmount;
  final double hours;
  final double minutes;
  final double seconds;
  final double noOfSections;
  final double rating;

  WishList( {required this.id,required this.title, required this.imageUrl, required this.instructorName, required this.priceCurrency, required this.priceAmount,
    required this.hours, required this.minutes,
    required this.seconds, required this.noOfSections, required this.rating});

  static List<WishList> parseSectionFromServer(dynamic serverData) {
    print('parseSectionFromServer $serverData');
    dynamic results = serverData['resutls'];
    print('parseSectionFromServer5 $results');

    if (results != null && results is List) {
      print('parseSectionFromServer2');
      return results.map<WishList>((wishList) {
        print('parseSectionFromServer3 $wishList');
        print('parseSectionFromServer3 ${(wishList['price']['amount'] )}');
         return WishList(
             id:wishList['_id'] ,
             title: wishList['title'],
             imageUrl: wishList['thumbnail'],
             instructorName: wishList['instructor'],
             priceCurrency: wishList['price']['currency'],
             priceAmount: wishList['price']['amount'] ,
             hours: (wishList['duration']['hours'] as num).toDouble(),
             minutes: (wishList['duration']['minutes'] as num).toDouble(),
             seconds: (wishList['duration']['seconds'] as num).toDouble(),
             noOfSections: (wishList['sections'] as num).toDouble(),
             rating: (wishList['ratingsAverage'] as num).toDouble()

        );
      }).toList();
    } else {
      print('error parseSectionFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'Course{sectionName: , ';
  }
}
