import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class FanControlScreen extends StatefulWidget {
  const FanControlScreen({Key? key}) : super(key: key);

  @override
  State<FanControlScreen> createState() => _FanControlScreenState();
}

class _FanControlScreenState extends State<FanControlScreen> {
  final DatabaseReference _fanStatusRef =
      FirebaseDatabase.instance.reference().child('fan').child('status');

  void _turnFanOn() {
    _fanStatusRef.set('on');
  }

  void _turnFanOff() {
    _fanStatusRef.set('off');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
          ),
          title: Text("Control Fan"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _turnFanOn,
              child: Text('Turn Fan On'),
            ),
            ElevatedButton(
              onPressed: _turnFanOff,
              child: Text('Turn Fan Off'),
            ),
          ],
        ));
  }
}
