import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future createUser() async {
    // استدعاء المستخدم الحالي مباشرة هنا
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      ChatUser chatUser = ChatUser(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        about: "hello iam mosalm cours",
        image: "",
        pushtoken: "",
        online: false,
      );

      await firebaseFirestore.collection("users").doc(user.uid).set(chatUser.tojson());
    }
  }
}
