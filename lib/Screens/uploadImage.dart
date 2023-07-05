import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intruderdetection/Screens/UploadAndViewImages.dart';
import 'package:intruderdetection/models/faces.dart';
import 'package:intruderdetection/viewmodel/face_viewmodel.dart';
import 'package:provider/provider.dart';

import '../Services/firebase_service.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/global_ui_viewmodel.dart';

class AddKnowFaces extends StatefulWidget {
  @override
  State<AddKnowFaces> createState() => _AddKnowFacesState();
}

class _AddKnowFacesState extends State<AddKnowFaces> {
  // database
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  late FaceViewModel _face;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    _face = Provider.of<FaceViewModel>(context, listen: false);
    super.initState();
  }

  List<String> _uploadedImageUrls = [];
  bool buttonPressed = false;
  String name = '';

  TextEditingController face_name = new TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  File? image;
  String? imagePath;
  String? imageUrl;
  final form = GlobalKey<FormState>();
  @override
  Future setImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> uploadImage(File file, String name) async {
    var p0 = await FirebaseService.storageRef
        .child("faces")
        .child("$name.jpg")
        .putFile(file);

    var url = await p0.ref.getDownloadURL();
    setState(() {
      imagePath = p0.ref.fullPath;
      imageUrl = url;
    });
  }

  Future<void> faceadding() async {
    // _ui.loadState(true);
    try {
      await _face
          .addFace(Face(
              name: name, imagepath: imagePath!, imageurl: imageUrl, docId: ""))
          .then((value) => null)
          .catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[900],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadAndViewImages()));
                  },
                ),
                title: Text(
                  "Add Image",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Times New Roman"),
                ),
              ),
              backgroundColor: Colors.black,
              body: Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: form,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Center(
                        child: ListView(
                      children: [
                        InkWell(
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF9846BE),
                              radius: 85,
                              child: CircleAvatar(
                                backgroundImage: image != null
                                    ? FileImage(File(image!.path))
                                        as ImageProvider
                                    : AssetImage(
                                        'assets/images/dummyProfileImage.jfif'),
                                radius: 80,
                              ),
                            ),
                          ),
                          onTap: (() {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => bottomSheet(context));
                          }),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: face_name,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Face Name is required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: "Name",
                              labelStyle: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: myFocusNode.hasFocus
                                      ? Color.fromARGB(255, 233, 231, 234)
                                      : Color.fromARGB(255, 238, 238, 238)),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          onChanged: (value) => setState(() {
                            name = value;
                          }),
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        SizedBox(height: 40),
                        SizedBox(
                          width: 70,
                          height: 50,
                          child: ElevatedButton(
                            onHover: (value) {
                              setState(() {
                                !buttonPressed;
                                ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white);
                              });
                            },
                            onPressed: (() {
                              buttonPressed = !buttonPressed;
                              // if (true) {
                              if (form.currentState!.validate()) {
                                uploadImage(image!, name).then((value) {
                                  faceadding();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Face Added Sucessfully")));
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UploadAndViewImages()));
                                });
                              }
                            }),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 234, 226, 226),
                              foregroundColor: Color.fromARGB(255, 16, 16, 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                  ),
                ),
              ))),
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: double.infinity,
        height: size.height * 0.2,
        child: Column(
          children: [
            Text("Choose Profile Photo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: () {
                    setImage(ImageSource.gallery);
                  },
                ),
                SizedBox(
                  width: 80,
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: (() {
                    setImage(ImageSource.camera);
                  }),
                ),
              ],
            )
          ],
        ));
  }
}
