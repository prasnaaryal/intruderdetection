import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Services/firebase_service.dart';
import '../models/faces.dart';

class FaceRepo{
  FirebaseStorage storage = FirebaseStorage.instance;
  
     CollectionReference<Face> faceRef =
      FirebaseService.db.collection("knownFaces").withConverter<Face>(
            fromFirestore: (snapshot, _) {
              return Face.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Future<void> addFace({required Face face}) async {
    try {
      var docref = faceRef.doc();
      face.name=docref.id;
      await docref.set(face);
    } catch (err) {
      rethrow;
    }
  }   

    
  

  Future<String> downoladUrl(String? image) async{
    print("IamImage $image");
    String downoladUrl =await storage.ref("profile/$image.jpg").getDownloadURL();
    print("iamdownlodedurl $downoladUrl");
    return downoladUrl;
  }

      
  

  }
  