import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DoctorsGpt extends StatefulWidget {
  const DoctorsGpt({super.key});

  @override
  State<DoctorsGpt> createState() => _DoctorsGptState();
}

class _DoctorsGptState extends State<DoctorsGpt> {
  _openCamera() {
    if (_image == null) {
      _getimagefromcamera();
    }
  }

  TextEditingController _controller = TextEditingController();
  String customPrompt = "";
  String _responsebody = "";
  bool _isSending = false;
  XFile? _image;
  bool startRecord = false;
  final SpeechToText speech = SpeechToText();
  bool inAvailable = false;

  @override
  void initState() {
    make();
    // TODO: implement initState
    super.initState();
  }

  make() async {
    inAvailable = await speech.initialize();
    setState(() {});
  }

  FlutterTts flutterTts = FlutterTts();
  speak() async {
    await flutterTts.speak(_responsebody);
    flutterTts.setLanguage("hi-IN");
  }

  Future<void> _getimagefromcamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ImageCropper cropper = ImageCropper();
      final croppedImage =
          await cropper.cropImage(sourcePath: image.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ]);

      setState(() {
        _image = croppedImage != null ? XFile(croppedImage.path) : null;
      });
    }
  }

  Future<void> sendImage(XFile? imagefile) async {
    if (imagefile == null) return;
    setState(() {
      _isSending = true;
    });

    String based64Image = base64Encode(File(imagefile.path).readAsBytesSync());
    String apiKey = "AIzaSyAb_PblvYANG6ki-lzR8evaqVSuETOsk1g";
    String requestBody = json.encode({
      "contents": [
        {
          "parts": [
            {
              "inlineData": {"mimeType": "image/jpeg", "data": based64Image}
            },
            {
              "text": customPrompt == ""
                  ? "Please describe a disease or medicine in both English and Hindi languages. Additionally, provide precautions for the disease, and if it's a medicine, give use cases in both Hindi and English languages. \n"
                  : customPrompt
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.05,
        "topK": 32,
        "topP": 1,
        "maxOutputTokens": 4096,
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        }
      ]
    });
    http.Response response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: requestBody);
    print("Sent:$customPrompt");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      setState(() {
        _responsebody =
            jsonBody["candidates"][0]["content"]["parts"][0]["text"];
        _isSending = false;
      });
      print("Image sent successfully");
    } else {
      print("Request Faild");
      setState(() {
        _isSending = false;
      });
    }
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _responsebody = "";
                        _image = null;
                        customPrompt = '';
                      });
                    },
                    icon: Icon(
                      Icons.refresh,
                    )),
                IconButton(
                    onPressed: () {
                      speak();
                    },
                    icon: Icon(
                      Icons.volume_down,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      flutterTts.stop();
                    },
                    icon: Icon(
                      Icons.volume_off,
                      size: 27,
                    )),
              ],
            ),
          )
        ],
        title: Text(
          "Tabeeb",
          style: TextStyle(
              color: const Color.fromARGB(
                255,
                255,
                255,
                255,
              ),
              fontFamily: 'Amaranth',
              fontWeight: FontWeight.bold,
              wordSpacing: 5,
              letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 4),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: _image == null
                          ? Text(
                              "No Image is Selected 🙂",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          : Image.file(File(_image!.path)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _responsebody,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Amaranth'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(50)),
              height: 60,
              width: double.infinity,
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: AvatarGlow(
                          animate: startRecord,
                          glowColor: Theme.of(context).primaryColor,
                          child: GestureDetector(
                              onTapDown: (value) {
                                flutterTts.stop();

                                setState(() {
                                  startRecord = true;
                                });
                                if (inAvailable) {
                                  speech.listen(onResult: (value) {
                                    setState(() {
                                      customPrompt = value.recognizedWords;
                                      _controller.text = value.recognizedWords;
                                    });
                                  });
                                }
                              },
                              onTapUp: (value) {
                                setState(() {
                                  startRecord = false;
                                });
                                speech.stop();
                              },
                              child: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ))),
                      hintText: 'Custom Prompt',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      )),
                  controller: _controller,
                  onChanged: (value) => customPrompt = value,
                ),
              ),
            ),
          ),
          if (_isSending)
            Center(
                child: Lottie.asset(
              'assets/animations/mation.json',
              height: 130,
            )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.amber,
        backgroundColor: Colors.white,
        onPressed: () {
          _image == null ? _openCamera() : sendImage(_image);
        },
        tooltip: _image == null ? 'Pick Image' : 'Send',
        child: Icon(
          _image == null ? FontAwesomeIcons.camera : FontAwesomeIcons.share,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
