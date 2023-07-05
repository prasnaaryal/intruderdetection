import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/dashboard.dart';
import 'package:intruderdetection/Screens/uploadImage.dart';
import 'package:intruderdetection/models/faces.dart';
import 'package:intruderdetection/viewmodel/face_viewmodel.dart';
import 'package:provider/provider.dart';

import 'UnKnownFaceDetails.dart';

class ViewImagesIntruders extends StatefulWidget {
  const ViewImagesIntruders({Key? key}) : super(key: key);

  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImagesIntruders> {
  late FaceViewModel faceViewModel;
  late List<String> imageUrls;

  @override
  void initState() {
    faceViewModel = Provider.of<FaceViewModel>(context, listen: false);
    try {
      print("faces get try block");
      faceViewModel.getFace();
    } catch (e) {
      print("getface error $e");
    }
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FaceViewModel>(
      builder: (context, faceVM, child) {
        return Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            title: Text('Intruders',style: TextStyle(
              color: Colors.white,
              fontFamily: "Times New Roman",
            ),),
          ),
          body: ListView.builder(
            itemCount: faceVM.allFace.length,
            itemBuilder: (BuildContext context, int index) {
              Face face = faceVM.allFace[index];
              print("face printed in model $face");
              return ListTile(
                leading: Image.network(face.imageurl!),
                title: Text(face.name!,style: TextStyle(
                  color: Colors.white,
                ),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UnknownFaceDetails()),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey[800],
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
