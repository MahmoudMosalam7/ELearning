import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'fire_database.dart';

class FireStorage {
  final FirebaseStorage fireStorage=FirebaseStorage.instance;
  sendImage({required File file,required String roomid , required String uid}) async {
    String ext=file.path.split(".").last;
    final ref=fireStorage.ref().child("image/$roomid/${DateTime.now().millisecondsSinceEpoch}.$ext");
    await ref.putFile(file);
    String imageUrl=await ref.getDownloadURL();
    // print(imageUrl);
    FireData().sendMessage(uid, imageUrl, roomid, type: "image");
  }
}