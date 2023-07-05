import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/Notification.dart';
import 'package:intruderdetection/Screens/UploadAndViewImages.dart';
import 'package:intruderdetection/Screens/UploadAndViewImagesIntruders.dart';
import 'package:intruderdetection/Screens/biometrics_login.dart';
import 'package:intruderdetection/Screens/changepin.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                    '23 Jan, 2023',
                    style: TextStyle(
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  // Handle press event here
                  // Add your desired functionality
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                  // print('Container pressed!');
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
              )
            ],
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
                              onPressed: () {},
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
                                    'Button B',
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
      ]),
    );
  }
}
