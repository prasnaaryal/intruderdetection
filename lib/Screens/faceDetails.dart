import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intruderdetection/Screens/photos.dart';
import 'package:intruderdetection/models/faces.dart';
import 'package:intruderdetection/viewmodel/auth_viewmodel.dart';
import 'package:intruderdetection/viewmodel/face_viewmodel.dart';
import 'package:intruderdetection/viewmodel/global_ui_viewmodel.dart';
import 'package:provider/provider.dart';

class KnownFaceDetails extends StatefulWidget {
  late Face face;
 
  KnownFaceDetails({required this.face});

  @override
  State<KnownFaceDetails> createState() => _KnownFaceDetailsState();
}

class _KnownFaceDetailsState extends State<KnownFaceDetails> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadAndViewImages()));
              }),
              icon: Icon(Icons.cut_outlined))
        ],
      ),
      body: Center(

        child: ListView(
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              child: CircleAvatar(
                radius: 150,
                  backgroundImage: NetworkImage(widget.face.imageurl!)),
                onTap: () {
                  print("path of the image displayed: ${widget.face.imagepath}");
                },
            ),
            Text(widget.face.name!),
            ElevatedButton(
                onPressed: (() {
                  print("delete button clicked ${widget.face.docId}");
                  _face.deleteFace(widget.face).then((value) {
                    _face.delete(widget.face);
                    print("face documnet to delete ${widget.face.docId}");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Face Deleted sucessfully")));
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadAndViewImages()));
                  });
                }),
                child: Text("Delete"))
          ],
        ),
      ),
    );
  }
}
