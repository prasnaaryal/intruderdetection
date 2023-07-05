import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/intruder_viewmodel.dart';
import 'dashboard.dart';

class UploadAndViewImagesIntruders extends StatefulWidget {
  const UploadAndViewImagesIntruders({Key? key}) : super(key: key);

  @override
  State<UploadAndViewImagesIntruders> createState() =>
      _UploadAndViewImagesIntrudersState();
}

class _UploadAndViewImagesIntrudersState
    extends State<UploadAndViewImagesIntruders> {
  late IntruderViewModel intruderViewModel;
  late List<String> imageUrls;

  @override
  void initState() {
    intruderViewModel = Provider.of<IntruderViewModel>(context, listen: false);
    try {
      print("faces get try block");
      intruderViewModel.getImageNameFromUrl(imageUrls as String);
    } catch (e) {
      print("getface error $e");
    }
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IntruderViewModel>(
      builder: (context, faceVM, child) {
        return Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            title: Text(
              'Intruders',
              style: TextStyle(
                fontFamily: "Times New Roman",
                color: Colors.white,
              ),
            ),
          ),
          // body: ListView.builder(
          //   itemCount: faceVM.allFace.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     Face face = faceVM.allFace[index];
          //     print("face printed in model $face");
          //     return ListTile(
          //       leading: Image.network(face.imageurl!),
          //       title: Text(face.name!,style: TextStyle(
          //           color: Colors.white, fontFamily: "Times New Roman"
          //       ),),
          //       onTap: () {
          //         Navigator.pop(context);
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => UnknownFaceDetails(
          //                 face: face,
          //               )),
          //         );
          //       },
          //     );
          //   },
          // ),
        );
      },
    );
  }
}
