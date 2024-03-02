import 'file_and_video_of_section_model.dart';

class Section {
  String sectionName;
  List<PickFile> videos;
  Section({required this.sectionName, required this.videos });
  @override
  String toString() {
    return 'Course{sectionName: $sectionName, videos: ${videos}}';
  }
}
