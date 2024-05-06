import 'file_and_video_of_section_model.dart';

class ModuleModel {
  String name;
  String id;
  bool isFree;

  ModuleModel({
    required this.name,
    required this.id,
    required this.isFree
  });
  static List<ModuleModel> parseModuleFromServer(dynamic serverData) {
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

  static List<PickFile> ModuleFromServer(dynamic serverData) {
    print('ModuleFromServer $serverData');
    var results = serverData['modules'];
    print('ModuleFromServer5 $results');

    if (results != null && results is List) {
      print('ModuleFromServer2');
      return results.map<PickFile>((moduleData) {
        print('ModuleFromServer3 $moduleData');
        return PickFile(
          fileName: moduleData['name'], // Access 'name' instead of 'title'
          idServ: moduleData['_id']

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