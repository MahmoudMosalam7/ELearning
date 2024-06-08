class ChatRoom{
  String? id;
  List ? members;
  String? lastmessage;
  String? lastmessagetime;
  String? creatAT;
ChatRoom(
  {
    required this.id,
    required this.members,
    required this.lastmessage,
    required this.lastmessagetime,
    required this.creatAT,
} );
factory ChatRoom.fromjson(Map<String,dynamic> json){
  return ChatRoom(
      id: json['id']??"",
      members: json['members']??[],
      lastmessage: json['last_message']??"",
      lastmessagetime: json['last_messagetime']??"",
      creatAT: json['creat_AT']??""
  );
}
  Map<String,dynamic> tojson(){
  return{
    'id' :id,
    'members' :members,
    'last_message' :lastmessage,
    'last_messagetime' :lastmessagetime,
    'creat_AT' :creatAT,
  };
  }

}
