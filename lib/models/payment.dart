class Payment{
  final String transactionId;
 final String userID;
 final String courseID;
 final String imageUrl;
 final double price;
 final String currency;

  Payment({required this.transactionId ,required this.userID, required this.courseID, required this.imageUrl,
    required this.price,required this.currency});
 static List<Payment> parsePaymentFromServer(dynamic serverData) {
   print('parsePaymentFromServer $serverData');
   var results = serverData['data'];
   print('parsePaymentFromServer5 $results');

   if (results != null && results is List) {
     print('parsePaymentFromServer2');
     return results.map<Payment>((productData) {
       print('parsePaymentFromServer3 $productData');
       return Payment(
         imageUrl: productData['paymentReceiptImage'],
         userID: productData['userId'],
         price: productData['coursePrice']['amount'] ,
         currency:productData['coursePrice']['currency'] ,
         courseID: productData['courseId'],
         transactionId: productData['_id'],
       );
     }).toList();
   } else {
     print('error parsePaymentFromServer');
     throw Exception('No results found in server data');
   }
 }
 @override
 String toString() {
   return 'Product(imageURL: $imageUrl, title: $userID, price: $price, id: $courseID, )';
 }
}