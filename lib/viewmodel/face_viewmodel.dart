import 'package:flutter/material.dart';
import 'package:intruderdetection/repositories/knownFaceRepo.dart';

import '../models/faces.dart';

class FaceViewModel with ChangeNotifier{
  FaceRepo _taskRepo = FaceRepo();
  
  List<Face> _allFace =[];
  List<Face> get allTask => _allFace;
  
  




  Future<void> addFace(Face face ) async{
    try{
      await FaceRepo().addFace(face: face);
    } catch(err){
      rethrow;
    }
  }


  // Future<List<Task>> getTask(String user_id) async{
  //    _allTask=[];
  //     try{
  //       print(user_id);
  //       var response = await _taskRepo.getTask(user_id);
  //       for(var element in response){
  //         _allTask.add(element.data());
  //       }
  //       notifyListeners();
  //     }catch(e){
  //       print(e);
  //       _allTask=[];
  //       rethrow;
  //     }
  //     notifyListeners();
  //     return _allTask;

  // }

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