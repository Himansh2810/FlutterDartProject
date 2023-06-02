import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget
{
  @override
  State<AboutPage> createState () => _AbtState ();

}

class _AbtState extends  State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('About',style:TextStyle(color:Color(0xFF243a47),fontSize:23,fontWeight:FontWeight.bold),),
        backgroundColor:Color(0xFF66A2BA),
        elevation:0,
      ),
      body:Center(
        child: Padding(
        padding: const EdgeInsets.all(20),
        child:Expanded(
      child:SingleChildScrollView(
      child:RichText(
          text:TextSpan(
          text:'About App : \n\n'
              'created by : @himansh_u.28 (Intragram)\n'
              'created on : october 2022 \n'
              'Langauge used : Created in Android Studio by Dart & Flutter Languages\n'
              'I Know there is better option available Google Translater\n'
              'but this is my College Project , Hope you All Like it !! \n\n'
          'User Guide \n\n 1> Home Page \n\n'
          'Here you can directly translate to your wishful \n  language by typing in given textbox \n '
          'You can select a language on click dropdown boxes\n '
               'by clicking on swipeRight icon swap language translation options \n '
               'by clicking on translate button wait for some time \n '
               'after some time you can see result and also can copy it\n\n '
               '2>SpeechPage\n \n'
               'first select language you want to translate to .\n '
               'Click on microphone and start speaking \n '
               'then click again to stop and wait for some time you can see answer\n '
               'of both text you speaked and translated\n and copy it\n\n '
               '3>ImageScanPage\n\n '
               'Here you can choose image from gallary or \n '
               'you can take photo immediatly\n '
               'You can see text extracted from image and can copy it\n\n ',

          style:TextStyle(
            color:Color(0xFF243a47),
            fontSize:20,
            fontWeight:FontWeight.bold,
          ),

        ),
      ),),),),)
    );
  }
}