import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PickFile {
  String fileName;
  File? file;
  VideoPlayerController? videoController;
  SfPdfViewer? pdfViewer;
  String? pdfFilePath; // Added variable to store the PDF file path

  PickFile({required this.fileName, this.file});

  Future<void> pickAndAddFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'pdf', 'pptx'],
    );

    if (result != null && result.files.isNotEmpty) {
      File pickedFile = File(result.files.first.path!);
      addFile(pickedFile);
    }
  }

  void addFile(File pickedFile) {
    file = pickedFile;
    if (file != null) {
      if (file!.path.endsWith('.mp4')) {
        videoController = VideoPlayerController.file(file!);
      } else if (file!.path.endsWith('.pdf')) {
        // Use syncfusion_flutter_pdfviewer to handle PDF files
        _loadPDFViewer();
      } else if (file!.path.endsWith('.pptx')) {
        // Open PPTX file using url_launcher
        _launchPPTXFile();
      }
    }
  }

  void _loadPDFViewer() {
    pdfViewer = SfPdfViewer.file(file!);
    pdfFilePath = file!.path; // Store the PDF file path
    print('Could launch pdf file: $pdfFilePath');
  }

  Future<void> _launchPPTXFile() async {
    final filePath = file!.path;
    if (await canLaunch(filePath)) {
      await launch(filePath);
    } else {
      // Handle the case where the file cannot be launched
      print('Could not launch PPTX file: $filePath');
    }
  }

  @override
  String toString() {
    String pdfViewerInfo = pdfViewer != null
        ? 'PDFViewer{file: $pdfFilePath, ...}'  // Replace ... with other relevant details
        : 'null';

    return 'File{name: $fileName || file: ${file?.toString()} || videoController: ${videoController?.toString()} || pdfViewer: $pdfViewerInfo }';
  }
}
