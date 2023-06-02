
import 'package:flutter/material.dart';
import 'package:langlate/Ext/home.dart';
import 'package:langlate/Ext/speechlate.dart';
import 'package:langlate/Ext/imagelate.dart';

void main () => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home':(context) => Home(),
      '/speech': (context) => SpeechPage(),
      '/image' : (context) => ImagePage(),
    },
  )
);



