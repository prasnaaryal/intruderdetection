import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/dashboard.dart';

class TurbidityValue extends StatefulWidget {
  @override
  _TurbidityValueState createState() => _TurbidityValueState();
}

class _TurbidityValueState extends State<TurbidityValue> {
  DatabaseReference? _databaseReference;
  double turbidity = 0.0;
  List<Map<String, dynamic>> sensorData = [];

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.reference().child("test");
    _databaseReference!.child("turbidity").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          turbidity = double.parse(data.toString());
          sensorData.add({
            "timestamp": DateTime.now(),
            "turbidity": turbidity,
          });
        });
        checkTurbidityLevel();
      }
    });
  }

  void checkTurbidityLevel() {
    // Implement your logic to check the turbidity level
    // You can use the turbidity value and sensorData list here
    // For example, you can display a notification based on the turbidity value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Turbidity Value",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Times New Roman",
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "${turbidity.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Card(
                elevation: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 40,
                    dataRowHeight: 56,
                    horizontalMargin: 12,
                    headingTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    dataTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    columns: [
                      DataColumn(label: Text('Timestamp')),
                      DataColumn(label: Text('Turbidity Value')),
                    ],
                    rows: sensorData
                        .map(
                          (data) => DataRow(
                            cells: [
                              DataCell(Text(data['timestamp'].toString())),
                              DataCell(
                                Text(
                                  '${data['turbidity'].toStringAsFixed(1)}',
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
