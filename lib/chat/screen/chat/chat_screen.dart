import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../translations/locale_keys.g.dart';
import '../../firebase/fire_database.dart';
import '../../firebase/fire_storage.dart';
import '../../model/message_model.dart';
import '../../model/user_model.dart';
import '../../widget/chat_widget/chat_message_card.dart';

class ChatScreen extends StatefulWidget {
  final String roomid;
  final ChatUser chatUser;
  const ChatScreen({super.key, required this.roomid, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgCon=TextEditingController();
  List <String> selectedMsg =[];
  List <String> copyMsg =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(widget.chatUser.name!),
            Text(
              'widget.chatUser.lastactivated!',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        actions: [
          selectedMsg.isNotEmpty?
          IconButton(
            onPressed: () {
              FireData().deletMsg(widget.roomid, selectedMsg);
              setState(() {
                selectedMsg.clear();
                copyMsg.clear();
              });
            },
            icon: const Icon(Iconsax.trash),
          ):
          Container()
          ,
          copyMsg.isNotEmpty?
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: copyMsg.join(" \n")));
              setState(() {
                selectedMsg.clear();
                copyMsg.clear();
              });
            },
            icon: const Icon(Iconsax.copy),
          ):Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("rooms").doc(widget.roomid).collection("messages").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Message> messageItems=snapshot.data!.docs.map((e) => Message.fromjson(e.data())).toList()..
                      sort((a, b) => b.createdAT!.compareTo(a.createdAT!),);
                      return messageItems.isNotEmpty? ListView.builder(
                      reverse: true,
                      itemCount: messageItems.length,
                      itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMsg.isNotEmpty? selectedMsg.contains(messageItems[index].id)?
                              selectedMsg.remove(messageItems[index].id)
                                  :
                              selectedMsg.add(messageItems[index].id!):
                                  null;
                              selectedMsg.isNotEmpty?
                              messageItems[index].type=="text"?

                              copyMsg.contains(messageItems[index].msg)?
                              copyMsg.remove(messageItems[index].msg!):
                              copyMsg.add(messageItems[index].msg!):null
                              : null;
                            });
                          },
                          onLongPress: () {
                            setState(() {

                              selectedMsg.contains(messageItems[index].id)?
                                  selectedMsg.remove(messageItems[index].id!)
                              :
                              selectedMsg.add(messageItems[index].id!);

                              messageItems[index].type=="text"?

                              copyMsg.contains(messageItems[index].msg)?
                                  copyMsg.remove(messageItems[index].msg!):
                                  copyMsg.add(messageItems[index].msg!):null;
                            });
                          },
                          child: ChatMaessgeCard(
                            index: index, messageItem: messageItems[index], roomid: widget.roomid, selected: selectedMsg.contains(messageItems[index].id),
                          ),
                        );
                      },
                    ):
                      Center(
                        child: GestureDetector(
                          onTap:()=>FireData().sendMessage(
                              widget.chatUser.id!,
                              "${LocaleKeys.SayAssalamuAlaikum.tr()}👋",
                              widget.roomid!) ,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "👋",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "${LocaleKeys.SayAssalamuAlaikum.tr()}",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      ;
                    }
                     return Container();
                  }
                ),
    )


            ,Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: msgCon,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.emoji_happy),
                              ),
                              IconButton(
                                onPressed: () async{
                                  ImagePicker picker=ImagePicker();
                                  XFile ?image=await picker.pickImage(source: ImageSource.gallery);
                                  if(image!=null){
                                   File(image.path);///***************************************************************************************
                                  FireStorage().sendImage(
                                   file:  File(image.path),roomid:  widget.roomid, uid: widget.chatUser.id!, );
                                  }
                                },
                                icon: const Icon(Iconsax.camera),
                              ),
                            ],
                          ),
                          border: InputBorder.none,
                          hintText: "${LocaleKeys.Message.tr()}",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10)),
                    ),
                  ),
                ),
                IconButton.filled(onPressed: () {
                 if(msgCon.text.isNotEmpty){
                   FireData().sendMessage(
                       widget.chatUser.id!,
                       msgCon.text,
                       widget.roomid)
                   .then((value) => setState(() {
                     msgCon.text="";
                   })
                       )
                   ;
                 }
                }, icon: Icon(Iconsax.send_1))
              ],
            )
          ],
        ),
      ),
    );
  }
}