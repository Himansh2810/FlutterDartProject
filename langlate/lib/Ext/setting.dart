import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget
{
  @override
  State<SettingPage> createState () => _SetState ();

}

class _SetState extends  State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      title:Text('Settings',style:TextStyle(color:Color(0xFF243a47),fontSize:23,fontWeight:FontWeight.bold),),
      backgroundColor:Color(0xFF66A2BA),
      elevation:0,
    ),
      body:Center(
        child:Text(
          'Nothing to Set !! ',
          style:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:25,
            color:Color(0xFF243a47),
          ),
        ),
      )
    );
  }
}