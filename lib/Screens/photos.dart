import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intruderdetection/Screens/dashboard.dart';
import 'package:intruderdetection/Screens/uploadImage.dart';
import 'package:intruderdetection/models/faces.dart';
import 'package:intruderdetection/viewmodel/face_viewmodel.dart';
import 'package:provider/provider.dart';

class UploadAndViewImages extends StatefulWidget {
  const UploadAndViewImages({Key? key}) : super(key: key);

  @override
  _UploadAndViewImagesState createState() => _UploadAndViewImagesState();
}

class _UploadAndViewImagesState extends State<UploadAndViewImages> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  List<String> _uploadedImageUrls = [];

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
    }
  }

  late FaceViewModel faceViewModel;
  late  List<String> imageUrls;





  @override
  void initState() {
    faceViewModel = Provider.of<FaceViewModel>(context, listen: false);
   // fetchAndPrintUrls();
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
   
    return  Consumer<FaceViewModel>(
    builder: (context, faceVM, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
          ),
          title: Center(child: Text('Known Faces')),
        ),
        body: ListView.builder(
          itemCount: faceVM.allFace.length,
          itemBuilder: (BuildContext context, int index) {
            Face face = faceVM.allFace[index];
            return ListTile(
              leading: Image.network(face.imageurl!),
              title: Text(face.name!),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[800],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddKnowFaces(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    },
  );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Consumer<FaceViewModel> (
//        builder:(context, faceVM, child){
//         return Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Dashboard()));
//               },
//             ),
//             title: Center(child: Text('Known Faces')),
//           ),
//           body:  ListView(children: [
//                   ...faceVM.allFace.map((e) => ListTile(
//                     leading: Image.network(e.imageurl!),
//                     title: Text(e.name!),

//                   ))
//                 ],),
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.blue[800],
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddKnowFaces(),
//                 ),
//               );
//             },
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//           ),
//         );
//       }
//     );
//   }