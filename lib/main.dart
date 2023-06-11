import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/Signin.dart';
import 'package:intruderdetection/Screens/dashboard.dart';
// import 'package:intruderdetection/Screens/login.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp();
  }catch(e){
    print(e);
  }
  runApp(MaterialApp(
    navigatorKey: navigatorkey,
    debugShowCheckedModeBanner: false,
    initialRoute: "login",
    routes: {
      "login":(context) => Signin(),
    },
  ));
}

final navigatorkey=GlobalKey<NavigatorState>();

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) =>Scaffold(
    body:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting){
          //   return Center(child: CircularProgressIndicator());
          // }git

          if(snapshot.hasError){
            return Center(child:Text("Something went wrong !"));

          }else if (snapshot.hasData){
            // if the user is logged in
            return Dashboard();

          }else
            //  if the user is looged out
            return Signin();
        }
    ),
  );
}

// onpressed:()=>FirebaseAuth.instance.signOut(),