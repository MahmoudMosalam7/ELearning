
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../model/message_model.dart';
import '../model/room_model.dart';

class FireData{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myuid=FirebaseAuth.instance.currentUser!.uid;//
  Future creatRoom( String email)async{
    QuerySnapshot userEmail=await firestore.
    collection('users')
        .where('email',isEqualTo: email).get();

        if(userEmail.docs.isNotEmpty){
          String userid =userEmail.docs.first.id;
          List<String> members=[myuid,userid]..sort((a, b) => a.compareTo(b),);
          QuerySnapshot roomExist=await firestore.collection("rooms").where("members",isEqualTo: members).get();
          if(roomExist.docs.isEmpty){
            ChatRoom chatRoom = ChatRoom(
                id: members.toString(),
                members: members,
                lastmessage:"",
                lastmessagetime: DateTime.now().microsecondsSinceEpoch.toString(),
                creatAT: DateTime.now().microsecondsSinceEpoch.toString());
            await firestore.collection("rooms").doc(members.toString()).set(chatRoom.tojson());

          }
        }
        }
     Future sendMessage(String uid,String msg,String roomId,{String ? type})async{
    String msgId=Uuid().v1();
    Message message=Message
      (id:msgId,
        toId: uid,
        fromId: myuid,
        msg: msg,
        type: type??"text",
        createdAT: DateTime.now().microsecondsSinceEpoch.toString(),
        read: ""
    );
    await firestore.collection("rooms")
        .doc(roomId)
        .collection("messages")
        .doc(msgId)
        .set(message.tojson());
    firestore.collection("rooms")
        .doc(roomId)
        .update({"last_message":type?? msg,"last_messagetime":DateTime.now().microsecondsSinceEpoch.toString()});
        }

Future readMessage(String roomId ,String msgId) async {
    firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .doc(msgId)
        .update(
        {"read":DateTime.now().millisecondsSinceEpoch.toString()});

}
    deletMsg(String roomid,List<String> msgs) async{
    for(var element in msgs){
      await firestore.collection("rooms").doc(roomid).collection("messages").doc(element).delete();
    }
    }
    }

