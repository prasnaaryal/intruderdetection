// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/login.dart';
import 'package:intruderdetection/customs/app_bar.dart';
import 'package:intruderdetection/customs/custom_back_button.dart';


class Changepassword extends StatefulWidget {
  const Changepassword ({Key? key}) : super(key: key);

  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final _formKey = GlobalKey<FormState>();

  bool _obsecured = true;

  var current = "";
  var newpassword = "";
  var confirmpassword = "";

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final currenrUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    if (newController.text == confirmController.text)
    try {
      await currenrUser!.updatePassword(newController.text);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text("Successfully Changed Password! Login Again to Continue"),
      ));
    } on FirebaseAuthException catch(e){

      if (e.code == "wrong-password") {
        print("Old password donot match");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Wrong Password for this User",
              style: TextStyle(fontSize: 19),
            )));

      }

      else if (e.code == "password already used") {
        print("Password Already used");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Password already used",
              style: TextStyle(fontSize: 19),
            )));
      }
    } on Exception catch(e){
        print(e.toString());
    }
    else {
      print("Password and confirm Password does not match");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Password and confirm Password does not match",
            style: TextStyle(fontSize: 19),
          )));
    }
  }

  String radioClickedValue = "";
  bool? checkBoxValue1 = false;
  bool? checkBoxValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: "Change Password",
          actions: [],
          leading: CustomBackButton(tapEvent: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

          })
      ),
      backgroundColor: Color.fromRGBO(205, 231, 238, 1.0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        child: Text("Your New password must not be the old passwords you used",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey
                        ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          obscureText: _obsecured,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // label: Text("Password"),
                              hintText: " Current Password",
                              prefixIcon: Icon(Icons.star),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obsecured = !_obsecured;
                                    });
                                  },
                                  icon: _obsecured
                                      ? const Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility))),
                          controller: currentController,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          obscureText: _obsecured,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // label: Text("Password"),
                              hintText: " New Password",
                              prefixIcon: Icon(Icons.star),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obsecured = !_obsecured;
                                    });
                                  },
                                  icon: _obsecured
                                      ? const Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility))),
                          controller: newController,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "    Please Enter Password";
                            }
                            return null;
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          obscureText: _obsecured,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // label: Text("Email"),
                              hintText: "Confirm Password",
                              prefixIcon: Icon(Icons.star),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obsecured = !_obsecured;
                                  });
                                },
                                icon: _obsecured
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              )),
                          controller: confirmController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "     Please Enter Password";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        setState(() {
                          newpassword = newController.text;
                        });
                        changePassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(93, 108, 137, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    child: Text("Change Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}