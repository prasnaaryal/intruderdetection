// To parse this JSON data, do
//
//     final face = faceFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Face faceFromJson(String str) => Face.fromJson(json.decode(str));

String faceToJson(Face data) => json.encode(data.toJson());

class Face {
    String? name;
    String imagepath;
    String? imageurl;
    String? docId;

    Face({
        required this.name,
        required this.imagepath,
        required this.imageurl,
        required this.docId,
    });

    factory Face.fromJson(Map<String, dynamic> json) => Face(
        name: json["name"],
        imagepath: json["imagepath"],
        imageurl: json["imageurl"],
        docId: json["docId"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imagepath": imagepath,
        "imageurl": imageurl,
        "docId": docId,
    };

      
    factory Face.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => Face(
   
    docId:json["docId"],
    name:json["name"], 
    imagepath: json["imagepath"],
    imageurl: json["imageurl"],
    
 
  );
}
