import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/UploadAndViewImages.dart';
import 'package:intruderdetection/Screens/UploadAndViewImagesIntruders.dart';
import 'package:intruderdetection/Screens/WaterTem_value.dart';
import 'package:intruderdetection/Screens/biometrics_login.dart';
import 'package:intruderdetection/Screens/changepin.dart';
import 'package:intruderdetection/Screens/ph.dart';

import 'Fan.dart';
import 'Notification.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

// Helper method to get the month name
String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 70,
                  horizontal: 30), // Add padding around the entire widget
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .end, // Align children to the right side of the Row
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Wrap the Text widgets with Expanded
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Sanjeela!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              // fontFamily: "Times New Roman",
                            ),
                          ),
                          SizedBox(height: 10), // Add spacing between the texts
                          Text(
                            '${DateTime.now().day} ${_getMonthName(DateTime.now().month)}, ${DateTime.now().year}',
                            style: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width:
                            16), // Add spacing between the texts and GestureDetector
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: screenWidth,
                    color: Colors.black26,
                    child: Column(
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          buttonPadding: EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Button Face Recognition action
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => UploadAndViewImages(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(180, 150),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/faceScan.png', // Replace with your image path
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text(
                                    'Face Recognition',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Button Intruder Face Recognition action
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => FanControlPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(180, 150),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/fan.png', // Replace with your image path
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text(
                                    'Fan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      // Button Intruder Face Recognition action
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UploadAndViewImagesIntruders(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: Size(180, 150),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/intruders.png', // Replace with your image path
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Intruders',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => pHvalue(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: Size(180, 150),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ph.png', // Replace with your image path
                                          width: 70,
                                          height: 70,
                                        ),
                                        Text(
                                          'pH',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Button Intruder Face Recognition action
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => WaterTempValue(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: Size(180, 150),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/waterTemperature.png', // Replace with your image path
                                        width: 60,
                                        height: 60,
                                      ),
                                      Text(
                                        'Water Temperature',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Button Face Recognition action
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Changepassword(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: Size(180, 150),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/changePass.png', // Replace with your image path
                                        width: 60,
                                        height: 60,
                                      ),
                                      Text(
                                        'Change Password',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ButtonBar(
                              // alignment: MainAxisAlignment.spaceBetween,
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Fingerprint(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: Size(180, 50),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Icon(
                                        Icons.logout,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
