import 'package:flutter/material.dart';
import 'package:langlate/Ext/imagelate.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:langlate/Ext/speechlate.dart';
import 'package:langlate/Ext/imagelate.dart';
import 'package:langlate/Ext/speechlate.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:langlate/Ext/textlate.dart';
import 'package:langlate/Ext/about.dart';
import 'package:langlate/Ext/setting.dart';
import 'package:page_transition/page_transition.dart';

enum Menu{
  setting,about
}
//theme colors : #66A2BA (Spblue) & #243A47 (SpdBlue),,#7e3eff , #f9b143

class Home extends StatefulWidget
{
  @override
  State<Home> createState () => Test1State ();
}

class Test1State extends  State<Home>
{
  int _page=0;

  final List<Widget> _pageItems = [TextL(), SpeechPage(), ImagePage()];
  final List<Widget> _icons =[Icon(Icons.translate,color:Color(0xFF243a47)),Icon(Icons.mic,color:Color(0xFF243a47)),Icon(Icons.image_outlined,color:Color(0xFF243a47))];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Row(
          children:[
            Container(
             // margin:EdgeInsets.only(left:108),
              child:_icons[_page],
            ),
            Image.asset('assets/lango.png',height:240,),
            Container(
            )
          ]
        ),
        backgroundColor:Color(0xFF66A2BA),
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            color:Color(0xfff9b143),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            onSelected:(value){
              if(value == Menu.setting)
              {
                  Navigator.push(context,PageTransition(type: PageTransitionType.leftToRight, child:SettingPage()));
              }
              else{
                Navigator.push(context,PageTransition(type: PageTransitionType.leftToRight, child:AboutPage()));
              }
            },
              itemBuilder: (context) => [
                PopupMenuItem(
                    value:Menu.setting,
                    child:RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Icon(Icons.settings,color:Color(0xFF243a47),size: 19,),
                            ),
                          ),
                          TextSpan(
                            text: ' Settings ',
                            style:TextStyle(
                              color:Color(0xFF243a47),
                              fontSize:20,
                              fontWeight:FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                PopupMenuItem(
                    value:Menu.about,
                    child:RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Icon(Icons.account_circle,color:Color(0xFF243a47),size: 19,),
                            ),
                          ),
                          TextSpan(
                            text: ' About App',
                            style:TextStyle(
                              color:Color(0xFF243a47),
                              fontSize:20,
                              fontWeight:FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                )
              ]
          )
        ],
      ),
      body: _pageItems[_page],
      bottomNavigationBar: CurvedNavigationBar(
        height:65,
        backgroundColor: Colors.white,
        color: Color(0xFF66a2ba),
        buttonBackgroundColor: Color(0xFFf9b143).withOpacity(0.95),
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 500),
        items: <Widget>[
          Icon(Icons.home_outlined,size: 32),
          Icon(Icons.speaker_phone_sharp,size: 32),
          Icon(Icons.image_outlined,size: 32),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}