import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/UploadAndViewImages.dart';
import 'package:intruderdetection/models/faces.dart';
import 'package:intruderdetection/viewmodel/auth_viewmodel.dart';
import 'package:intruderdetection/viewmodel/face_viewmodel.dart';
import 'package:intruderdetection/viewmodel/global_ui_viewmodel.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
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
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadAndViewImages(),
                ),
              );
            },
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius:
                      100, // Adjust the radius to make the CircleAvatar smaller
                  backgroundImage: NetworkImage(widget.face.imageurl!),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Center(
                  child: Text(
                    widget.face.name!,
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 32, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Adjust the font weight as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  print("delete button clicked ${widget.face.docId}");
                  _face.deleteFace(widget.face).then((value) {
                    _face.delete(widget.face);
                    print("face document to delete ${widget.face.docId}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Face Deleted successfully")),
                    );
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UploadAndViewImages(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // Background color of the button
                  onPrimary: Colors.white, // Text color of the button
                  textStyle: TextStyle(
                    fontSize: 22, // Font size of the text
                    fontWeight: FontWeight.bold, // Font weight of the text
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 12), // Adjust padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Rounded corners with border radius
                    // You can also set other properties for the button shape, like side: BorderSide(color: Colors.black, width: 2)
                  ),
                ),
                child: Text("Delete"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
