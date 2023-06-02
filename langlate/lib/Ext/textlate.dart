import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:clipboard/clipboard.dart';

class TextL extends StatefulWidget
{
  @override
  State<TextL> createState () => _Test1State ();

}

class _Test1State extends  State<TextL>
{
  var result ;
  final translator = GoogleTranslator();

  _translateText()
  {
    final input=myController.text;
    if(input != '') {
      translator.translate(input, to: tolang.toString().substring(0, 2),
          from: fromlang.toString().substring(0, 2)).then((res) {
        setState(() {
          result = res.toString();
        });
      });
    }
  }
  final myController = TextEditingController();

  bool _isVisible= false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  List<String> _locations = ['en:English', 'hi:Hindi','gu:Gujarati','te:Telugu','ta:Tamil','mr:Marathi','ml:Malayalam',
    'kn:Kannada','fr:French', 'es:Spanish', 'sv:Swedish','de:German','el:Greek','ur:Urdu','ar:Arabic','it:Italian',
    'ja:Japanese', 'ru:Russian'];
  String? fromlang='en:English';
  String? tolang='hi:Hindi';

  FocusNode myFocusNode = new FocusNode();
  bool press= true;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
        reverse:true,
       child: Column(
          children:[
            Container(
              margin:EdgeInsets.only(right:225,top:12),
            child:Text(
                'Translate from ',
                style: TextStyle(
                    color: Color(0xFFf9b143),
                    fontWeight: FontWeight.bold,
                    fontSize: 25)
            ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, top:15, right: 0, bottom:28),
            child:Row(
              children: [

               SizedBox(
                  width:160,
                  height:48,
                  child:DecoratedBox(
                    decoration: BoxDecoration(
                        color:Color(0xFF66a2ba),
                        borderRadius: BorderRadius.all(Radius.circular(5)), //border raiuds of dropdown button
                        boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.4), //shadow for button
                              blurRadius: 3) //blur radius of shadow
                        ]
                    ),
                    child:Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child:DropdownButton<String>(
                        dropdownColor:Color(0xFFF9B143),
                        icon:Icon(
                          Icons.arrow_drop_down_outlined,
                          color:Color(0xFF243a47),
                        ),
                        style:TextStyle(
                            color: Color(0xFF243a47),
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                        hint: Text(
                            'en:English',
                            style: TextStyle(
                                color:Color(0xFF243a47),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)
                        ),
                        value: fromlang,
                        onChanged: (newValue) {
                          setState(() {
                            fromlang = newValue;
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
                Container(
                  margin: EdgeInsets.only(left:0,right:0),
                  child:IconButton(
                    onPressed:(){
                      setState(() {
                        String? temp = tolang;
                        tolang = fromlang;
                        fromlang = temp;
                      });
                    },
                    icon:Icon(Icons.swipe_right,color:Color(0xFFf9b143)),
                  )
                ),
                SizedBox(
                    width:160,
                    height:48,
                    child:DecoratedBox(
                      decoration: BoxDecoration(
                          color:Color(0xFF66a2ba),
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
                            color:Color(0xFF243a47),
                          ),
                          style:TextStyle(
                              color: Color(0xFF243a47),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          hint: Text(
                              'hi:Hindi',
                              style: TextStyle(
                                  color: Color(0xFF243a47),
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
            SizedBox(
              width:375,
            child:TextField(
              controller: myController,
              focusNode:myFocusNode,
              cursorColor:Color(0xFF243a47),
              decoration: InputDecoration(
                  icon: Icon(Icons.text_fields,color:Color(0xFFf9b143),),
                border: OutlineInputBorder(),
                hintText: 'Enter a Text ',
                  labelText: 'Enter Text to Translate',
                labelStyle:TextStyle(color:Color(0xFFf9b243))

              ),

            ),
            ),
            Container(
              margin:EdgeInsets.only(top:10,left:230,bottom:20),
            child:SizedBox(
              child:ElevatedButton(
                onPressed:(){
                  _translateText();
                  setState(() {
                    _isVisible = true;
                  });
                },//_translateText,
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Color(0xFF66a2ba)),
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
                            color:Color(0xFF243a47),
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
            Visibility(
              visible:_isVisible,
                child:SizedBox(
                  width:380,
                  child:DecoratedBox(
                    decoration: BoxDecoration(
                      color:Color(0xFF66a2ba),
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
                                      color:Color(0xFF243a47)
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
            )
          ]
      ),
      ),
      floatingActionButton:FloatingActionButton.extended(
        backgroundColor:Color(0xFF66a2ba),
        label:Text('Reset',style:TextStyle(fontSize:18,color:Color(0xFF243a47)),),
        icon:Icon(Icons.refresh,color:Color(0xFFf9b143),size:20,),
        onPressed:(){
          setState(()=>{
            fromlang='en:English',
            tolang='hi:Hindi',
            myController.text='',
            result='',
            _isVisible=false
          });
        },

      )
    );
  }
}