import 'package:flutter/material.dart';

class LerningReminder extends StatefulWidget{
  @override
  State<LerningReminder> createState() => _remState();
}

class _remState extends State<LerningReminder> {
  @override
  bool s=true;


  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Learning reminders'),
        centerTitle: true,
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Text("set a learning reminder to help you meet ypur goals faster. you can change the frequncy or turn them off in your account seting at any time ",
                style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w300
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
                          Text("learning reminders ",
                            style: TextStyle(
                                fontSize: 17.5,
                                fontWeight:FontWeight.w400
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
                      )
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Frequncy ",
                            style: TextStyle(
                                fontSize: 17.5,
                                fontWeight:FontWeight.w400
                            ),),
                          Text("evening, weekdays",
                            style: TextStyle(
                                fontSize: 17.5,
                                fontWeight:FontWeight.w400
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
      )

      ,
    );
  }
}