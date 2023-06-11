import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
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
                    "hi Harry!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '23 Jan, 2023',
                    style: TextStyle(color: Colors.blue[200]),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              // SafeArea(
              //   child: Expanded(
              //       child: Container(
              //     padding: EdgeInsets.fromLTRB(100, 10, 100, 100),
              //     color: Colors.grey[100],
              //     child: Text(
              //       'Icons',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20,
              //       ),
              //     ),
              //   )),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
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
                color: Colors.white,
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
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[800],
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
                            // Button Change password action
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[800],
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
                                'PIN Code',
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
                                // Button Face Recognition action
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[800],
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
                                // Button Change password action
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[800],
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
                                    'PIN Code',
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
                                    builder: (context) => Dashboard(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(180, 50),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
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
