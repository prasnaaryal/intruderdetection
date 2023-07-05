import 'package:flutter/material.dart';
import 'package:intruderdetection/repositories/intruderPhoto_repo.dart';

class IntruderViewModel extends ChangeNotifier {
  final IntruderRepo intruderRepo;

  IntruderViewModel({required this.intruderRepo});
  List<String> imageUrls = [];

  void fetchImageUrlsFromFolder() async {
    try {
      imageUrls = await intruderRepo.downloadUrlsFromFolder();
      notifyListeners();
    } catch (error) {
      // Handle error appropriately
      print('Error fetching image URLs: $error');
    }
  }

  String getImageNameFromUrl(String imageUrl) {
    return intruderRepo.getImageNameFromUrl(imageUrl);
  }
}
