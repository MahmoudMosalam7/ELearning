class ModuleModel {
  String name;
  String id;
  bool isFree;

  ModuleModel({
    required this.name,
    required this.id,
    required this.isFree
  });static List<ModuleModel> parseModuleFromServer(dynamic serverData) {
    print('parseModulesFromServer $serverData');
    var results = serverData['modules'];
    print('parseModulesFromServer5 $results');

    if (results != null && results is List) {
      print('parseModulesFromServer2');
      return results.map<ModuleModel>((moduleData) {
        print('parseModulesFromServer3');
        return ModuleModel(
          name: moduleData['name'], // Access 'name' instead of 'title'
          id: moduleData['_id'],
          isFree: moduleData['isFree'],
        );
      }).toList();
    } else {
      print('error parseModulesFromServer');
      throw Exception('No results found in server data');
    }
  }

  @override
  String toString() {
    return 'Product(name: $name, id: $id, isFree: $isFree)';
  }
}