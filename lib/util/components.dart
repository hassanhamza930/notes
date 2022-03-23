import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';


class appIcon extends StatefulWidget {
  appIcon({@required this.width,@required this.height});
  final double width;
  final double height;

  @override
  _appIconState createState() => _appIconState();
}

class _appIconState extends State<appIcon> {
  @override
  Widget build(BuildContext context) {
    var width=widget.width;
    var height=widget.height;
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Center(
            child: Icon(Icons.edit,size: 60,color: Colors.black,)
        )
    );
  }
}






TextStyle customText({bold=false,size=18.0,colora=Colors.white}){
  return TextStyle(fontWeight: bold==true?FontWeight.w700:FontWeight.normal,fontFamily: "Kufam",fontSize: size,color: colora);
}





