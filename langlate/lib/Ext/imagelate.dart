import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:material_color_generator/material_color_generator.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor:Colors.white,
        primarySwatch:generateMaterialColor(color: Color(0xff66a2ba)),
       // visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => TextRecognitionState(),
         child: TextRecognitionPage(),
      ),
    );
  }
}

class TextRecognitionPage extends StatefulWidget {
  @override
  _TextRecognitionPageState createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  TextRecognition? _textRecognition = TextRecognition(
    options:TextRecognitionOptions.Devanagari,
  );

  final maxLines =9;
  final myController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textRecognition?.dispose();
    super.dispose();
    myController.dispose();
    super.dispose();
  }

  Future<void> _startRecognition(InputImage image) async {
    TextRecognitionState state = Provider.of(context, listen: false);

    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _textRecognition?.process(image);
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
    child:InputCameraView(
      mode: InputCameraMode.gallery,
      resolutionPreset: ResolutionPreset.high,
      title:'Image To Text',
      onImage: _startRecognition,
      overlay: Consumer<TextRecognitionState>(
        builder: (_, state, __) {
          if (state.isNotEmpty) {
            myController.text=state.text;
            return Center(
              child:Align(
                alignment:Alignment(0,1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 51, horizontal: 16),
                decoration: BoxDecoration(
                  color:Color(0xff66a2ba).withOpacity(0.95),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child:SizedBox(
                    height: 10*26,
                  child:Column(
                    children: [
                       RawScrollbar(
                         controller:_scrollController,
                         thumbVisibility:true,
                         thumbColor:Color(0xfff9b143),
                         radius:Radius.circular(10),
                         thickness:4,
                         child:TextField(
                        maxLines: maxLines,
                        controller: myController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border:InputBorder.none,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                       ),
                      Align(
                        alignment:Alignment.bottomRight,
                      child:TextButton(
                        onPressed: () async {
                          await FlutterClipboard.copy(myController.text);
                          Flushbar(
                            message:"Text from Image Copied Successfully !!",
                            messageColor:Colors.black,
                            duration:Duration(seconds: 2),
                              backgroundColor: Color(0xFFf9b143)
                          )..show(context);
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
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            );
          }
          return Container();
        },
      ),
        ),
      ),
    );
  }
}

class TextRecognitionState extends ChangeNotifier {
  InputImage? _image;
  RecognizedText? _data;
  bool _isProcessing = false;

  InputImage? get image => _image;
  RecognizedText? get data => _data;
  String get text => _data!.text;
  bool get isNotProcessing => !_isProcessing;
  bool get isNotEmpty => _data != null && text.isNotEmpty;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set data(RecognizedText? data) {
    _data = data;
    notifyListeners();
  }
}

