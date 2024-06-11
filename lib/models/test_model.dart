
class TestModel {
  final String question;
  final String choice1;
  final String choice2;
  final String choice3;
  final String choice4;
  final double correctAnswer;

  TestModel({required this.question, required this.choice1,
    required this.choice2, required this.choice3, required this.choice4,
    required this.correctAnswer, required String id});

  static List<TestModel> parseTestFromServer(dynamic serverData) {
    print('parseTestFromServer ${serverData}');
    dynamic results = serverData;
    print('parseTestFromServer $results');

    if (results != null && results is List) {

      return results.map<TestModel>((testModel) {
        print('parseReviewsFromServer4 $testModel');
        return TestModel(
            question: testModel['question'],
            choice1: testModel['choices'][0],
            choice2: testModel['choices'][1],
            choice3: testModel['choices'][2],
            choice4: testModel['choices'][3],
            correctAnswer: (testModel['correctAnswer'] as num).toDouble(),
          id:testModel['_id'] ,
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