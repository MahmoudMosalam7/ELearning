class UserModel {
  String name;
  String id;
  String email;
  String phone;
  String roles;
  String imageUrl;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.roles,
    required this.imageUrl,
  });
  static List<UserModel> parseProductsFromServer(dynamic serverData) {
    print('parseUserFromServer $serverData');
    var results = serverData['data']?['results'];
    print('parseUserFromServer5 $results');

    if (results != null && results is List) {
      print('parseUserFromServer2');
      return results.map<UserModel>((productData) {
        print('parseUserFromServer3 $productData');
        return UserModel(
          name: productData['name'],
          id: productData['_id'],
          email:productData['email'] ,
          phone: productData['phone'],
          roles: productData['roles'],
          imageUrl: productData['profileImage'],
        );
      }).toList();
    } else {
      print('error parseUserFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'User(name: $name, id: $id, phone: $phone, id: $id, email: $email, imageUrl: $imageUrl )';
  }
}