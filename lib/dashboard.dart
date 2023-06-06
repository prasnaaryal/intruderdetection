import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 52.0,
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 52.0,
                      )
                      // Image.asset(
                      //   "assets/images/profile.png",
                      //   width: 52.0,
                      // )
                      //for user profile
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Welcome to Intruder System",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20.0,
                      children: <Widget>[
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/img.png",
                                        width: 70.0,
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                        child: ElevatedButton(
                                          child: Text(
                                            "Upload Photo",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, "/photo");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/img_2.png",
                                        width: 64.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Pin",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/img_1.png",
                                        width: 64.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Notification",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
