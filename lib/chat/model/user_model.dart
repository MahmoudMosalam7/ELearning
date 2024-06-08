class ChatUser{
  String? id;
  String? name;
  String? email;
  String? about;
  String? image;/*
  String? createdAT;
  String? lastactivated;*/
  String? pushtoken;
  bool? online;

  ChatUser(
      {
        required this.id,
        required this.name,
        required this.email,
        required this.about,
        required this.image,/*
        required this.createdAT,
        required this.lastactivated,*/
        required this.pushtoken,
        required this.online,
      } );
  factory ChatUser.fromjson(Map<String,dynamic> json){
    return ChatUser(
        id: json['id']??"",
        name: json['name']??[],
        email: json['email']??"",
        about: json['about']??"",
        image: json['image']??"",/*
        createdAT: json['created_AT']??"",
        lastactivated: json['last_activated']??"",*/
        pushtoken: json['push_token']??"",
        online: json['online']??"",

    );
  }
  Map<String,dynamic> tojson(){
    return{
      'id' :id,
      'name' :name,
      'email' :email,
      'about' :about,
      'image' :image,/*
      'created_AT' :createdAT,
      'last_activated' :lastactivated,*/
      'push_token' :pushtoken,
      'online' :online,
    };
  }

}
