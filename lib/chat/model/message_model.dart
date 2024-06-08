class Message{
  String? id;
  String? toId;
  String? fromId ;
  String? msg;
  String? type;
  String? createdAT;
  String? read;

  Message(
      {
        required this.id,
        required this.toId,
        required this.fromId,
        required this.msg,
        required this.type,
        required this.createdAT,
        required this.read,
      } );
  factory Message.fromjson(Map<String,dynamic> json){
    return Message(
      id: json['id']??"",
      toId: json['to_id']??[],
      fromId: json['from_id']??"",
      msg: json['msg']??"",
      type: json['type']??"",
      createdAT: json['created_AT']??"",
      read: json['read']??"",


    );
  }
  Map<String,dynamic> tojson(){
    return{
      'id' :id,
      'to_id' :toId,
      'from_id' :fromId,
      'msg' :msg,
      'type' :type,
      'created_AT' :createdAT,
      'read' :read,

    };
  }

}
