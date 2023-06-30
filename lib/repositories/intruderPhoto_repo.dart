import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Services/firebase_service.dart';
import '../models/faces.dart';

class FaceRepo{
  FirebaseStorage storage = FirebaseStorage.instance;
  
     CollectionReference<Face> faceRef =
      FirebaseService.db.collection("securityPhotos").withConverter<Face>(
            fromFirestore: (snapshot, _) {
              return Face.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );


  Future<String> downoladUrl(String? image) async{
    print("IamImage $image");
    String downoladUrl =await storage.ref("securityPhotos/$image.jpg").getDownloadURL();
    print("iamdownlodedurl $downoladUrl");
    return downoladUrl;
  }
  
  
  Future<List<String>> downloadUrlsFromFolder() async {
    List<String> imageUrls = [];

    try {
      final Reference folderRef = storage.ref().child("securityPhotos");
      final ListResult result = await folderRef.listAll();
      final List<Reference> files = result.items;

      final List<Future<String>> downloadURLs =
          files.map((Reference fileRef) => fileRef.getDownloadURL()).toList();
      final List<String> resolvedUrls = await Future.wait(downloadURLs);

      imageUrls.addAll(resolvedUrls);
    } catch (error) {
      // Handle error appropriately
      print('Error fetching image URLs: $error');
    }

    return imageUrls;
  }

   String getImageNameFromUrl(String imageUrl) {
    Uri uri = Uri.parse(imageUrl);
    String imagePath = uri.path;
    String imageName = imagePath.substring(imagePath.lastIndexOf('/') + 1);
    return imageName;
  }

  

  Future<void> deletePhoto(Face face) async{
    try{
      await FirebaseService.storageRef.child(face.imagepath).delete();
    }catch(e){
       print("storage delete error $e");
       rethrow;
    }

  }


  }
  