// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.id,
    this.userId,
    this.imageUrl,
    this.imagePath,
    this.fcm,
    this.email,
    this.password,
  });

  String? id;
  String? userId;
 
  String? imageUrl;
  String? imagePath;
  String? fcm;
  String? email;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userId: json["user_id"],
       
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        fcm: json["fcm"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        
        "imageUrl": imageUrl,
        "imagePath": imagePath,
        "fcm": fcm,
        "email": email,
        "password": password,
      };
  factory UserModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => UserModel(
        id: json.id,
        userId: json["user_id"],
       
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        fcm: json["fcm"],
        email: json["email"],
        password: json["password"],
      );

}