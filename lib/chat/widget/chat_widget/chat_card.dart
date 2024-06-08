
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/message_model.dart';
import '../../model/room_model.dart';
import '../../model/user_model.dart';
import '../../screen/chat/chat_screen.dart';

class chat_card extends StatelessWidget {
  final ChatRoom item;
  const chat_card({
    super.key, required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String userid = item.members!.where((element) => element != FirebaseAuth.instance.currentUser!.uid).first;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(userid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          ChatUser chatUser=ChatUser.fromjson(snapshot.data!.data()!);
          return Card(
          child: ListTile(
            onTap: () => Navigator.push(context,MaterialPageRoute
              (builder: (context)=>ChatScreen(roomid: item.id!, chatUser: chatUser,))),
            leading: CircleAvatar(),
            title: Text(chatUser.name!),
            subtitle: Text(item.lastmessage! ==''? chatUser.about!: item.lastmessage!,maxLines: 1,overflow: TextOverflow.ellipsis, ),
            trailing:StreamBuilder(
                stream: FirebaseFirestore.instance.collection("rooms").doc(item.id).collection("messages").snapshots(),
                builder: (context,snapshot){
                  final unReadList=snapshot.data?.docs
                      .map((e) => Message.fromjson(e.data())).
                  where((element) => element.read=="")
                  .where((element) => element.fromId != FirebaseAuth.instance.currentUser!.uid)?? [];
                  return unReadList.length!=0?
                    Badge(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      label: Text(unReadList.length.toString() ),
                      largeSize: 30,
                    ):
                  Text(item.lastmessagetime.toString())
                  ;
          },
          ),
        ));
        }
        else{
          return Container();
        }
      }
    );
  }
}

