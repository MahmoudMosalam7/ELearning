
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../firebase/fire_database.dart';
import '../model/room_model.dart';
import '../widget/chat_widget/chat_card.dart';
import '../widget/text_fild.dart';

class ChatHomeScreen extends StatefulWidget {
  final String email;

  const ChatHomeScreen({super.key, required this.email});
  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  TextEditingController emailcon =TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.email.isNotEmpty) {
      FireData().creatRoom(widget.email.toLowerCase()).then((value) {
        setState(() {
         // widget.email = "";
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (widget.email.isNotEmpty) {
      print(widget.email);
      FireData().creatRoom(widget.email.toLowerCase()).then((value) {
        setState(() {
          // widget.email = "";
        });
      });
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // استدعاء دالة showBottomSheet وتمريرها بنية الـ BottomSheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Friend Email",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Spacer(),
                        IconButton.filled(
                          onPressed: () {},
                          icon: Icon(Iconsax.scan_barcode),
                        )
                      ],
                    ),
                    CustomField(
                      controller: emailcon,
                      icon: Iconsax.direct,
                      lable: "Email",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer
                        ),
                        onPressed: () {
                          if(emailcon.text.isNotEmpty) {
                            FireData().creatRoom(emailcon.text).then((value) {
                              setState(() {
                                emailcon.text="";
                              });
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Center(
                          child: Text("Create Chat"),
                        )
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.message_add),
      ),
      appBar: AppBar(
        title: Text("chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child:
              StreamBuilder(
                  stream: FirebaseFirestore.instance.
                  collection("rooms").
                  where("members",arrayContains: FirebaseAuth.instance.currentUser!.uid )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      List<ChatRoom> items=snapshot.data!.docs.map((e) =>
                          ChatRoom.fromjson
                            (e.data())).toList()
                        ..sort((a, b) => b.lastmessagetime!.compareTo(a.lastmessagetime!),);
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return chat_card(item: items[index],);
                          }
                      );
                    }
                    else{
                      return Center(child: CircularProgressIndicator(),);

                    }
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}

