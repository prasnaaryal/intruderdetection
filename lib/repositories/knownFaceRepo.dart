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
      face.docId=docref.id;
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
  
  
  Future<List<String>> downloadUrlsFromFolder(String folderPath) async {
    List<String> imageUrls = [];

    try {
      final Reference folderRef = storage.ref().child("faces");
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

  Future<List<QueryDocumentSnapshot<Face>>> getKnownFaces()  async{
     try{
      final response = await faceRef.get();
      var faces = response.docs;
      return faces;
     }catch(err){
      rethrow;
     }
  }
  
  Future<void> deleteFace({required Face face}) async{
     try{
      await faceRef.doc(face.docId).delete();

      print("delete face repo riched");
     }catch(e){
      print("face delete repo error $e");
      rethrow;
     }
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
  