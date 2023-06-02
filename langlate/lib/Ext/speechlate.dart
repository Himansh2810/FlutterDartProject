import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:clipboard/clipboard.dart';

class SpeechPage extends StatefulWidget {
  SpeechPage({Key? key}) : super(key: key);

  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async{
    setState(() {
      _lastWords = result.recognizedWords;
      _isVisible=true;
    });
    await _translateText();
  }

  var result ;
  final translator = GoogleTranslator();

  _translateText()
  {
    final input=_lastWords;
    if(_lastWords != '') {
      translator.translate(
          input, to: tolang.toString().substring(0, 2), from: 'en').then((res) {
        setState(() {
          result = res.toString();
        });
      });
    }
  }
  List<String> _locations = ['en:English', 'hi:Hindi','gu:Gujarati','te:Telugu','ta:Tamil','mr:Marathi','ml:Malayalam',
    'kn:Kannada','fr:French', 'es:Spanish', 'sv:Swedish','de:German','el:Greek','ur:Urdu','ar:Arabic','it:Italian',
    'ja:Japanese', 'ru:Russian'];
  String? tolang='hi:Hindi';

  bool _isVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        reverse:true,
      child:Center(
          child:Column(
          children: <Widget>[
          Container(
          margin:EdgeInsets.only(right:220,top:12,left:18),
            child:Text(
             'Speak & Translate from ',
               style: TextStyle(
                color: Color(0xFFf9b143),
                fontWeight: FontWeight.bold,
                fontSize: 25)
            ),
          ),
            Container(
              margin: EdgeInsets.only(left: 20, top:15, right: 0, bottom:28),
              child:Row(
                children: [

                  SizedBox(
                      width:174,
                      height:48,
                      child:DecoratedBox(
                        decoration: BoxDecoration(
                            color:Color(0xff66a2ba),
                            borderRadius: BorderRadius.all(Radius.circular(5)), //border raiuds of dropdown button
                            boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.4), //shadow for button
                                  blurRadius: 3) //blur radius of shadow
                            ]
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(left: 30,right: 30),
                          child:TextButton(
                            onPressed: (){
                              Flushbar(
                                  title:'You Can Only Speak In English',
                                  titleSize:22,
                                  titleColor:Colors.black,
                                  message:'Will Provide Other Language Support In Further Updates .',
                                  messageColor:Colors.black,
                                  duration:Duration(seconds: 3),
                                  backgroundColor: Color(0xFFf9b143)
                              )..show(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Color(0xff66a2ba)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                            ),
                            child:Text('en:English',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:Color(0xff243a47)),),
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left:5,right:5),
                    child:Icon(Icons.swipe_right,color:Color(0xFFf9b143)),
                  ),
                  SizedBox(
                      width:180,
                      height:48,
                      child:DecoratedBox(
                        decoration: BoxDecoration(
                            color:Color(0xff66a2ba),
                            borderRadius: BorderRadius.all(Radius.circular(10)), //border raiuds of dropdown button
                            boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                  blurRadius: 3) //blur radius of shadow
                            ]
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(left: 30,right: 30),
                          child:DropdownButton<String>(
                            dropdownColor:Color(0xFFF9B143),
                            icon:Icon(
                              Icons.arrow_drop_down_outlined,
                              color:Color(0xff243a47),
                            ),
                            style:TextStyle(
                                color:Color(0xff243a47),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                            hint: Text(
                                'hi:Hindi',
                                style: TextStyle(
                                    color: Color(0xff243a47),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)
                            ),
                            value: tolang,
                            onChanged: (newValue) {
                              setState(() {
                                tolang = newValue;
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      )
                  ),

                ],
              ),
            ),
            Visibility(
                visible:_isVisible,
                child:SizedBox(
              width:380,
              child:DecoratedBox(
                decoration: BoxDecoration(
                    color:Color(0xff66a2ba),
                    borderRadius: BorderRadius.all(Radius.circular(7)), //border raiuds of dropdown button
                    boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5), //shadow for button
                          blurRadius: 3) //blur radius of shadow
                    ]
                ),
                child:Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child:Expanded(
                          child:SingleChildScrollView(
                            child:RichText(
                                text:TextSpan(
                                    text:_lastWords,
                                    style:TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:Color(0xff243a47)
                                    )
                                )
                            ),),)
                    ),
                    Align(
                      alignment:Alignment.bottomRight,
                      child:TextButton(
                          onPressed:() async{
                            if(_lastWords != '')
                            {
                              await FlutterClipboard.copy(_lastWords);
                              Flushbar(
                                  message:"Speach Text Copied Successfully !!",
                                  messageSize:18,
                                  messageColor:Colors.black,
                                  duration:Duration(seconds: 2),
                                  backgroundColor: Color(0xFFf9b143)
                              )..show(context);
                            }

                          },
                          child:RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    child: Icon(Icons.content_copy,color:Color(0xFFf9b143),size: 18,),
                                  ),
                                ),
                                TextSpan(
                                  text: ' Copy ',
                                  style:TextStyle(
                                    color:Color(0xFF243a47),
                                    fontSize:20,
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),


              ),
            ),
            ),
           Container(margin:EdgeInsets.all(15),),
            Visibility(
                visible:_isVisible,
                child:SizedBox(
              width:380,
              child:DecoratedBox(
                decoration: BoxDecoration(
                    color:Color(0xff66a2ba),
                    borderRadius: BorderRadius.all(Radius.circular(7)), //border raiuds of dropdown button
                    boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5), //shadow for button
                          blurRadius: 3) //blur radius of shadow
                    ]
                ),
                child:Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child:Expanded(
                          child:SingleChildScrollView(
                            child:RichText(
                                text:TextSpan(
                                    text:result,
                                    style:TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:Color(0xff243a47)
                                    )
                                )
                            ),),)
                    ),
                    Align(
                      alignment:Alignment.bottomRight,
                      child:TextButton(
                          onPressed:() async{
                            if(result != '')
                            {
                              await FlutterClipboard.copy(result);
                              Flushbar(
                                  message:"Translated Text Copied Successfully !!",
                                  messageSize:18,
                                  messageColor:Colors.black,
                                  duration:Duration(seconds: 2),
                                  backgroundColor: Color(0xFFf9b143)
                              )..show(context);
                            }

                          },
                          child:RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    child: Icon(Icons.content_copy,color:Color(0xFFf9b143),size: 18,),
                                  ),
                                ),
                                TextSpan(
                                  text: ' Copy ',
                                  style:TextStyle(
                                    color:Color(0xff243a47),
                                    fontSize:20,
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),


              ),
            ),
            ),
            Container(
              margin:EdgeInsets.only(top:10,left:240,bottom:100),
              child:SizedBox(
                child:ElevatedButton(
                    onPressed:(){
                      _translateText;
                      setState(() {
                        _isVisible=true;
                      });
                      },
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Color(0xff66a2ba)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    ),
                    child:RichText(
                      text: TextSpan(
                        //style:
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Icon(Icons.translate,color:Color(0xFFf9b143),size: 20,),
                            ),
                          ),
                          TextSpan(
                            text: ' Translate ',
                            style:TextStyle(
                              color:Color(0xff243a47),
                              fontSize:22,
                              fontWeight:FontWeight.bold,
                            ),

                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
            Text(
              // If listening is active show the recognized words
              // If listening isn't active but could be tell the user
              // how to start it, otherwise indicate that speech
              // recognition is not yet ready or not supported on
              // the target device
              _speechToText.isListening ? 'Listening . . .' : _speechEnabled
                  ? 'Tap The Microphone To Start Speaking . . .' : 'Speech Not Available',
              style:TextStyle(
                fontSize:16,
                fontWeight:FontWeight.bold,
                color:Colors.orangeAccent
              ),
            )
          ],
        ),
      ),
      ),

      floatingActionButton:Stack(
        children: [
          Container(
            alignment:Alignment.bottomLeft,
            margin:EdgeInsets.only(left:30),
            child:FloatingActionButton.extended(
              backgroundColor:Color(0xFF66a2ba),
              label:Text('Reset',style:TextStyle(fontSize:18,color:Color(0xFF243a47)),),
              icon:Icon(Icons.refresh,color:Color(0xFFf9b143),size:20,),
              onPressed:(){
                setState(()=>{
                  tolang='hi:Hindi',
                  result='',
                  _lastWords='',
                  _isVisible=false
                });
              },
            ),
          ),
          Align(
            alignment:Alignment.bottomRight,
            child:FloatingActionButton(
              backgroundColor:Color(0xFF66a2ba),
              onPressed:_speechToText.isNotListening ? _startListening : _stopListening,

              // If not yet listening for speech start, otherwise stop
              tooltip: 'Listen',
              child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,color:Color(0xff243a47),),
            ),
          )
        ],
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';


class SpeechPage extends StatefulWidget {

  @override
  State<SpeechPage> createState() => SpeechState();

}

class SpeechState extends  State<SpeechPage>
{
  stt.SpeechToText? _speech;
  bool _isListening =false;
  String _textSpeech ="Press button to speak";

  void onListen() async{
    if(!_isListening)
    {
      bool? available=await _speech?.initialize(
        onStatus:(val) => print('onStatus :$val'),
        onError: (err) => print('onError :$err'),
        debugLogging: true,
      );
      if(available == true)
      {
        setState(() {
          _isListening=true;

        });
        _speech?.listen(
            onResult: (res) => setState(() {
              _textSpeech=res.recognizedWords;
            })
        );
      }else{
        setState(() {
          _isListening=false;
          _speech?.stop();
        });
      }
    }
  }

  @override
  void initstate()
  {
    super.initState();
    _speech=stt.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('LangLate  : SpeechToText'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
        elevation: 0.0,
      ),
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15,150),
              child:Text(
                _textSpeech,
                style:TextStyle(
                  fontSize:20,
                  color:Colors.black,

                ),
              ),
            ),
            AvatarGlow(
              animate: _isListening,
              glowColor: Theme.of(context).primaryColor,
              endRadius: 80,
              duration: Duration(milliseconds: 2000),
              repeatPauseDuration: Duration(milliseconds: 100),
              repeat: true,
              child:Align (
                alignment: Alignment.bottomCenter,
                child:FloatingActionButton(
                onPressed: () => onListen(),
                child: Icon(Icons.mic),),
            ),
            ),

          ]),
    );
  }
}*/
