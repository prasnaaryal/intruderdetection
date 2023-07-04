import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/KnownFaceDetails.dart';
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
            title: Text('Known Faces'),
          ),
          body: ListView.builder(
            itemCount: faceVM.allFace.length,
            itemBuilder: (BuildContext context, int index) {
              Face face = faceVM.allFace[index];
              print("face printed in model $face");
              return ListTile(
                leading: Image.network(face.imageurl!),
                title: Text(face.name!),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KnownFaceDetails(
                              face: face,
                            )),
                  );
                },
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
