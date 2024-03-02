import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Quality extends StatelessWidget{

  static String q="";
  Quality(){}
  @override
  Widget build(BuildContext context) {
    return(
        Scaffold(
          appBar: AppBar(
            /*  leading: IconButton(
        onPressed: (){
          Navigator.pop(context,MaterialPageRoute(
            builder: (context)=> Download_option() ),);
        },
        icon:Icon(
          Icons.keyboard_arrow_left
        )
      ),  */
            title: Text("video download quality"),

            centerTitle: true,
          ),

          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Text("Select your quality preference for videos you download. if the beast video quality is not available , then you will get the next highest level",
                    style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(height: 5.0),

                  SizedBox(height: 5.0),
                  Container(


                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: (){
                        q="360p";
                      },
                      child: Row(
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Data saver",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("360p- smallest file size",
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight:FontWeight.w300
                                ),),
                            ],
                          ),
                          Spacer(flex: 1,),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(

                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: (){
                        q="480p";
                      },
                      child: Row(
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Good",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("480p",
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight:FontWeight.w300
                                ),),
                            ],
                          ),
                          Spacer(flex: 1,),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(

                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: (){
                        q="720p";
                      },
                      child: Row(
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Better",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("720p",
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight:FontWeight.w300
                                ),),
                            ],
                          ),
                          Spacer(flex: 1,),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(

                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: (){
                        q="1080p";
                      },
                      child: Row(
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Best",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("1080p-largest file size",
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight:FontWeight.w300
                                ),),
                            ],
                          ),
                          Spacer(flex: 1,),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        )
    );
  }
}