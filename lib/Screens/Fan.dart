import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FanControlScreen(),
    );
  }
}

class FanControlScreen extends StatelessWidget {
  final DatabaseReference _fanSpeedRef =
      FirebaseDatabase.instance.reference().child('fan').child('speed');

  void _setFanSpeed(int speed) {
    // Update the fan speed value in Firebase
    _fanSpeedRef.set(speed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fan Speed Control"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _setFanSpeed(0), // Turn fan off
              child: Text('Turn Fan Off'),
            ),
            ElevatedButton(
              onPressed: () => _setFanSpeed(128), // Set fan speed to 50%
              child: Text('50% Speed'),
            ),
            ElevatedButton(
              onPressed: () => _setFanSpeed(255), // Set fan speed to 100%
              child: Text('100% Speed'),
            ),
          ],
        ),
      ),
    );
  }
}
