import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intruderdetection/Screens/uploadImage.dart';

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

  // Future<void> _viewUploadedImages() async {
  //   final storage = FirebaseStorage.instance;
  //   final storageRef = storage.ref().child('images');

  //   try {
  //     final listResult = await storageRef.listAll();
  //     final imageUrls = await Future.wait(
  //       listResult.items.map((ref) => ref.getDownloadURL()),
  //     );

  //     setState(() {
  //       _uploadedImageUrls = imageUrls;
  //     });

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             ViewUploadedImages(imageUrls: _uploadedImageUrls),
  //       ),
  //     );
  //   } catch (error) {
  //     print('Error fetching uploaded images: $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Known Faces'),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    height: 200,
                  ),
                SizedBox(height: 10),
                
                SizedBox(height: 10),
               
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
             AddKnowFaces(),
        ),
      );
      },),
    );
  }
}

class ViewUploadedImages extends StatefulWidget {
// final List<String> imageUrls;



  @override
  _ViewUploadedImagesState createState() => _ViewUploadedImagesState();
}

class _ViewUploadedImagesState extends State<ViewUploadedImages> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Uploaded Images'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: widget.imageUrls.length,
  //       itemBuilder: (context, index) {
  //         final imageUrl = widget.imageUrls[index];
  //         return Image.network(imageUrl);
  //       },
  //     ),
    );
  }
}
