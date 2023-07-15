import 'dart:convert';
import 'package:http/http.dart' as http;

class FCMService {
  static const String FCMAPI =
  "AAAAsdK2HNg:APA91bGrtZCXic04tQTdUpsZm-g-hitH-R-zwxrYj074UxApD8GKbM2hI-uN6VTD8uPiNiMBQkHv4blCZua8DH1o6fl8tDp2Ft95hjLvXwoY_l5atp3cw7cioPcK2znzzjGXmww-jeW_";
      static String makePayLoadWithToken(String? token, Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'to': token,
      'data': data,
      'notification': notification,
    });
  }

  static String makePayLoadWithTopic(String? topic, Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'topic': topic,
      'data': data,
      'notification': notification,
    });
  }

  static Future<void> sendPushMessage(String? token, Map<String, dynamic> data,
      Map<String, dynamic> notification) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$FCMAPI'
        },
        body: makePayLoadWithToken(token, data, notification),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
