import 'package:flutter/material.dart';
import 'package:intruderdetection/Services/firebase_service.dart';
import 'package:intruderdetection/repositories/knownFaceRepo.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/faces.dart';

class FaceViewModel with ChangeNotifier{
  FaceRepo _taskRepo = FaceRepo();
  
  List<Face> _allFace =[];
  List<Face> get allFace => _allFace;
  
  




  Future<void> addFace(Face face ) async{
    try{
      await FaceRepo().addFace(face: face);
    } catch(err){
      rethrow;
    }
  }

  
  Future<List<String>> fetchImageUrls(String folderPath) async {
    return FaceRepo().downloadUrlsFromFolder(folderPath);
  }

  

  String getImageNameFromUrl(String imageUrl) {
    return FaceRepo().getImageNameFromUrl(imageUrl);
  }

  Future<List<Face>> getFace() async{
     _allFace=[];
      try{
        
        var response = await FaceRepo().getKnownFaces();
        for(var element in response){
          print("response ${element.data()}");
          _allFace.add(element.data());
        }
        notifyListeners();
      }catch(e){
        print("error in view model $e");
        
        _allFace=[];
        rethrow;
      }
      notifyListeners();
      return _allFace;

  }

  Future<void> deleteFace(Face face) async{
    try{
      print("delete face viewmodel");
      await FaceRepo().deleteFace(face: face);
      notifyListeners();
    } catch(err){
      print("face delete repo error $err");
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
   Future<void> delete(Face face) async{
    try{
      await deletePhoto(face);
    }catch(e){
       print("storage delete error $e");
       rethrow;
    }

  }
   

 


}