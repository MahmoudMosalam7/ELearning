
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../firebase/fire_database.dart';
import '../../model/message_model.dart';

class ChatMaessgeCard extends StatefulWidget {
    final int index;
    final Message messageItem;
    final String roomid;
    final bool selected;
  const ChatMaessgeCard({
    super.key, required this.index, required this.messageItem, required this.roomid, required this.selected,
  });

  @override
  State<ChatMaessgeCard> createState() => _ChatMaessgeCardState();
}

class _ChatMaessgeCardState extends State<ChatMaessgeCard> {
@override
  void initState() {
  if(widget.messageItem.toId== FirebaseAuth.instance.currentUser!.uid){
    FireData().readMessage(widget.roomid, widget.messageItem.id!);

  }
super.initState();
  }
  @override

  Widget build(BuildContext context) {
    bool isMe=widget.messageItem.fromId==FirebaseAuth.instance.currentUser!.uid;
    return Container(
      decoration: BoxDecoration(
          color: widget.selected?Colors.grey: Colors.transparent,
      borderRadius: BorderRadius.circular(12)),
      margin:EdgeInsets.symmetric(vertical: 1),

      child: Row(
        mainAxisAlignment:isMe? MainAxisAlignment.end:MainAxisAlignment.start ,
        children: [
          isMe?
          IconButton(onPressed: (){}, icon: Icon(Iconsax.message_edit)):
          SizedBox(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(isMe?0:16),
                bottomLeft: Radius.circular(isMe?16:0),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),

              )
            ),
            color: isMe ? Colors.green[200]:Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width/2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.messageItem.type=="image"?
                    Container(child: Image.network(widget.messageItem.msg!),)
                        :
                    Text(widget.messageItem.msg!),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("12:15am"//DateTime.fromMillisecondsSinceEpoch(int.parse(messageItem.createdAT!)).toString()
                          ,style: TextStyle(fontSize: 7),),
                      SizedBox(width: 8,),
                      isMe ?
                      Icon( Iconsax.tick_circle,
                      size: 18,
                      color:widget.messageItem.read==""?Colors.red : Colors.blueAccent,
                      ):
                      SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
