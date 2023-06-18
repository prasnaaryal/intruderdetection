import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin
  = FlutterLocalNotificationsPlugin();

  static void initialize(){
    requestPermission();
    getToken();
    final InitializationSettings initializationSettings
    = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false
      )
    );
    _notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );

   
  }

  static void requestPermission() async {
  FirebaseMessaging massaging = FirebaseMessaging.instance;

  NotificationSettings settings = await massaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: false,
    provisional: false,
    sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User permission granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User granted provisional permission");
    } else{
      print("User declined or has not accepted permission");
    }
  
}

static void getToken() async {
  await FirebaseMessaging.instance.getToken().then(
    (token){
     print("My user token is $token");
    }
  );
}


  
  static BuildContext? context;
  static void onDidReceiveNotificationResponse
      (NotificationResponse? response){
      if(response!=null && response.payload!=null){
        Navigator.of(context!).pushNamed(response.payload.toString());
        print(response.payload);
      }
  }

  static Future<String> getImageFilePathFromAssets(
      String asset, String filename) async {
    final byteData = await rootBundle.load(asset);
    final temp_direactory = await getTemporaryDirectory();
    final file = File('${temp_direactory.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;
  }

  static Future<void> display(
      String title, String body,String payload, BuildContext _context
      ) async {
    context = _context;
    // if image from asset
    final bigpicture = await getImageFilePathFromAssets(
        'assets/images/logo.png', 'bigpicture');
    final smallpicture = await getImageFilePathFromAssets(
        'assets/images/logo.png', 'smallpicture');

    final styleinformationDesign = BigPictureStyleInformation(
      FilePathAndroidBitmap(smallpicture),
      largeIcon: FilePathAndroidBitmap(bigpicture),
    );


    final id = DateTime.now().millisecondsSinceEpoch ~/1000;
    final NotificationDetails notificationDetails
    = NotificationDetails(
      android: AndroidNotificationDetails(
        "myapp",
        "myapp channel",
        channelDescription: "Channel Description",
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: styleinformationDesign
      ),
      iOS: DarwinNotificationDetails()
    );
    _notificationsPlugin.show(
        id, title, body, notificationDetails,
        payload: payload
    );
  }


  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }


  static void displayFcm({required RemoteNotification notification, BuildContext? buildContext, String? payload}) async {
    try {
      if(buildContext !=null){
        context = buildContext;
      }
      var styleinformationDesign;
      if(notification.android!.imageUrl !=null){
        final bigpicture = await _downloadAndSaveFile(
            notification.android!.imageUrl.toString(), 'bigPicture');
        final smallpicture = await _downloadAndSaveFile(
            notification.android!.imageUrl.toString(), 'smallIcon');
        styleinformationDesign = BigPictureStyleInformation(
          FilePathAndroidBitmap(smallpicture),
          largeIcon: FilePathAndroidBitmap(bigpicture),
        );
      }

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "myapp",
              "myapp channel",
              channelDescription: "myapp channel description",
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: styleinformationDesign
          ),
          iOS: DarwinNotificationDetails()
      );
      await _notificationsPlugin.show(id, notification.title,
          notification.body, notificationDetails,payload: payload);
    } on Exception catch (e) {
      print(e.toString());
    }
  }


}