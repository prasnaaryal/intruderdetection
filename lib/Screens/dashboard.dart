import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/Notification.dart';
import 'package:intruderdetection/Screens/UploadAndViewImages.dart';
import 'package:intruderdetection/Screens/UploadAndViewImagesIntruders.dart';
import 'package:intruderdetection/Screens/biometrics_login.dart';
import 'package:intruderdetection/Screens/changepin.dart';
import 'package:intruderdetection/Screens/ph.dart';

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
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // greeting row
                  Text(
                    "Hi Sanjeela!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      // fontFamily: "Times New Roman",
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${DateTime.now().day} ${_getMonthName(DateTime.now().month)}, ${DateTime.now().year}',
                    style: TextStyle(
                      color: Colors.grey[200],
                    ),
                  ),

                  // Rest of the code...
                  // Padding(
                  //   padding: const EdgeInsets.all(30.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Column(
                  //         // crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           // greeting row
                  //           Text(
                  //             "Hi Sanjeela!",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 22,
                  //               fontWeight: FontWeight.bold,
                  //               // fontFamily: "Times New Roman",
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 8,
                  //           ),
                  //           Text(
                  //             '23 Jan, 2023',
                  //             style: TextStyle(
                  //               color: Colors.grey[200],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          // main white area
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.black26,
                  height: 470,
                  width: 100,
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
                                Icon(
                                  Icons.camera,
                                  size: 40,
                                  color: Colors.white,
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
                                Icon(
                                  Icons.pin_outlined,
                                  size: 40,
                                  color: Colors.white,
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
                      Row(
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            buttonPadding: EdgeInsets.symmetric(horizontal: 16),
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
                                    Icon(
                                      Icons.camera,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Intruders',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            pHvalue(),
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
                                    Icon(
                                      Icons.pin,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'pH',
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
                            buttonPadding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
