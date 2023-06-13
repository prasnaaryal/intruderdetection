
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar(BuildContext context, {required String title, required List<Widget> actions, required Widget leading }){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
        title,
        style: GoogleFonts.merriweather(
          color: Color.fromRGBO(29, 68, 89, 1.0),
          fontSize: 27,
        )
    ),
    leading: leading,
    actions: actions,

  );
}