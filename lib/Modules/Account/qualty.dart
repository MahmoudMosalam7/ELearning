import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../translations/locale_keys.g.dart';
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
            title: Text("${LocaleKeys.QualityTitle.tr()}"),

            centerTitle: true,
          ),

          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Text("${LocaleKeys.QualityText.tr()}",
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
                        children:  [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${LocaleKeys.QualityDatasaver.tr()}",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("${LocaleKeys.Qualitysmallestfilesize.tr()}",
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
                        children:  [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${LocaleKeys.QualityGood.tr()}",
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
                        children:  [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${LocaleKeys.QualityBetter.tr()}",
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
                        children:  [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${LocaleKeys.QualityBest.tr()}",
                                style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight:FontWeight.w400
                                ),),
                              Text("${LocaleKeys.Qualitylargestfilesize.tr()}",
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