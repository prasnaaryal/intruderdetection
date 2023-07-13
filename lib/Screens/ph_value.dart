import 'package:flutter/material.dart';
import 'package:intruderdetection/Screens/dashboard.dart';

class pHvalue extends StatefulWidget {
  const pHvalue({super.key});

  @override
  State<pHvalue> createState() => _pHvalueState();
}

class _pHvalueState extends State<pHvalue> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "pH value",
      home: Scaffold(
        backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('pH value'),
        leading: IconButton(
    icon: Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: (){
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard()));
    },
    ),
      ),
    body: Column(
      children: [
        ElevatedButton(
    child: Text("pH value"),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
      // height:100,
      // width:200,
    ),


    onPressed: (){
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ph value is 7.0"),backgroundColor: Colors.white,),

    );
    },

    ),

      ]
    ),


      ),
    );
  }
}
