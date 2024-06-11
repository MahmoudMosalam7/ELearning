import 'package:flutter/material.dart';
import 'package:learning/Modules/Account/qualty.dart';

class Download_option extends StatefulWidget{
  @override
  State<Download_option> createState() => _Download_optionState();
}

class _Download_optionState extends State<Download_option> {
  bool s=true;
  bool b=true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Download options',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ) ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Container(

                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> Quality()),);
                    },
                    child: Row(
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Video download quality",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight:FontWeight.w400
                              ),),
                            Text('720p',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight:FontWeight.w300
                              ),),
                          ],
                        ),
                          ],
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Download over WI-FI only"
                              ,style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight:FontWeight.w300
                              ),),

                          ],
                        ),
                        Spacer(flex: 1,),
                        Switch(value: s, onChanged: (value){
                          setState(() {
                            s=value;
                          });

                        },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),

                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Download to SD card ",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight:FontWeight.w300
                              ),
                            ),

                          ],
                        ),
                        Spacer(flex: 1,),
                        Switch(value: b, onChanged: (value){
                          setState(() {
                            b=value;
                          });

                        },
                          activeColor: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      )

      ,
    );
  }
}