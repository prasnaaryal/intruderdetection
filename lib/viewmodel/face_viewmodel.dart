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

  // Future<void> deleteTask(String id, String userId ) async{
    
  
  //   try{
  //     await TaskRepo().deleteTask(id).then((value) =>_allTask= TaskRepo().getTask(userId) as List<Task>);
  //     notifyListeners();
  //   } catch(err){
  //     rethrow;
  //   }
  // }

  // Future<void> updateTask(Task task) async{
  //   var doc = task.id;
  //   try{
  //     task.status=!task.status;
  //     await TaskRepo().updateTask(task);
  //     notifyListeners();
  //   }catch(e){
  //     rethrow;
  //   }
  // }



}