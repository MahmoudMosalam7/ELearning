import 'package:flutter/material.dart';

import '../../TColors.dart';

class Acount_Security extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return (Scaffold(
      appBar: AppBar(
        title: Text("Acount Security"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:   SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center ,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: TColors.Ternary, width: 2.0),
                      ),
                      child: CircleAvatar(

                        radius: 70.0,
                        backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text("Mahmoud Mosalam Mohammed ",
                      maxLines: 1,
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:15.0
                      ),
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("View public profile",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text(" Profile",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Photo",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Account security",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Subscriptions",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Payment methods",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Privacy",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Notifications",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("API clients",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: Container(width: double.infinity,
                        child: Text("Close account",
                          style: TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                    /***************************************************************************** */
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
    );
  }


}