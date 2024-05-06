import 'file_and_video_of_section_model.dart';
import 'module_model.dart';

class Section {
  String sectionName;
  String sectionId;
  List<PickFile> videos;
  Section({required this.sectionName,
    required this.sectionId
  , required this.videos });

  static List<Section> parseSectionFromServer(dynamic serverData) {
    print('parseSectionFromServer $serverData');
    var results = serverData['sections'];
    print('parseSectionFromServer5 $results');

    if (results != null && results is List) {
      print('parseSectionFromServer2');
      return results.map<Section>((sectionData) {
        print('parseSectionFromServer3 $sectionData');
        List<PickFile> videosOfSections = ModuleModel.ModuleFromServer(sectionData) ;
        return Section(
          sectionName: sectionData['title'], // Access 'name' instead of 'title'
          sectionId: sectionData['_id'],
          videos: videosOfSections,
        );
      }).toList();
    } else {
      print('error parseSectionFromServer');
      throw Exception('No results found in server data');
    }
  }
  @override
  String toString() {
    return 'Course{sectionName: $sectionName, ';
  }
}
