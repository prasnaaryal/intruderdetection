import 'package:flutter/material.dart';
import 'package:intruderdetection/repositories/knownFaceRepo.dart';

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

  Future<void> deleteFace(String id) async{
    try{
      print("delete face viewmodel");
      await FaceRepo().deleteFace(id);
      notifyListeners();
    } catch(err){
      print("face delete repo error $err");
      rethrow;
    }
  }




}