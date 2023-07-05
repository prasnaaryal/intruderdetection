import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/dashboard.dart';
import 'package:intruderdetection/viewmodel/intruder_viewmodel.dart';
import 'package:provider/provider.dart';

class UploadAndViewImagesIntruders extends StatefulWidget {
  const UploadAndViewImagesIntruders({Key? key}) : super(key: key);

  @override
  _UploadAndViewImagesIntrudersState createState() =>
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
      print("intruders get try block");
      intruderViewModel.fetchImageUrlsFromFolder();
    } catch (e) {
      print("fetchImageUrlsFromFolder error $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IntruderViewModel>(
      builder: (context, intruderVM, child) {
        return Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            title: Text(
              'Intruder Images',
              style: TextStyle(
                fontFamily: "Times New Roman",
                color: Colors.white,
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: intruderVM.imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              String imageUrl = intruderVM.imageUrls[index];
              print("intruder image URL: $imageUrl");
              return ListTile(
                leading: Image.network(imageUrl),
                onTap: () {
                  // Handle onTap event
                },
              );
            },
          ),
        );
      },
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../viewmodel/intruder_viewmodel.dart';
// import 'dashboard.dart';
//
// class UploadAndViewImagesIntruders extends StatefulWidget {
//   const UploadAndViewImagesIntruders({Key? key}) : super(key: key);
//
//   @override
//   State<UploadAndViewImagesIntruders> createState() =>
//       _UploadAndViewImagesIntrudersState();
// }
//
// class _UploadAndViewImagesIntrudersState
//     extends State<UploadAndViewImagesIntruders> {
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<IntruderViewModel>(
//       builder: (context, intruderViewModel, child) {
//         return Scaffold(
//           backgroundColor: Colors.black26,
//           appBar: AppBar(
//             backgroundColor: Colors.grey[900],
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Dashboard()),
//                 );
//               },
//             ),
//             title: Text(
//               'Intruders',
//               style: TextStyle(
//                 fontFamily: "Times New Roman",
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           body: ListView.builder(
//             itemCount: intruderViewModel.imageUrls.length,
//             itemBuilder: (BuildContext context, int index) {
//               String imageUrl = intruderViewModel.imageUrls[index];
//               return ListTile(
//                 leading: Image.network(imageUrl),
//                 title: Text(
//                   intruderViewModel.getImageNameFromUrl(imageUrl),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: "Times New Roman",
//                   ),
//                 ),
//                 onTap: () {
//                   // Perform action when an image is tapped
//                 },
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
