
class ReviewModel {
  final String name;
  final String imageUrl;
  final double rating;
  final String comment;
  ReviewModel( {required this.name,required this.imageUrl, required this.rating, required this.comment});
  static List<ReviewModel> parseReviewsFromServer(dynamic serverData) {
    print('parseReviewsFromServer ${serverData}');
    dynamic results = serverData;
    print('parseReviewsFromServer $results');

    if (results != null && results is List) {

      return results.map<ReviewModel>((reviewModel) {
        print('parseReviewsFromServer4 $reviewModel');
         return ReviewModel(
             name: reviewModel['user']['name'],
             imageUrl: reviewModel['user']['profileImage'],
             rating: (reviewModel['rate'] as num).toDouble(),
             comment: reviewModel['comment']

        );
      }).toList();
    } else {
      print('error parseSectionFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'Course{sectionName: ,${this.name} , image:${this.imageUrl}, ${this.comment} ,${this.rating} ';
  }

}