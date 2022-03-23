import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/pages/notes_page.dart';
import 'package:notes/util/components.dart';

var startedAnimation=false;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        startedAnimation=true;
      });
    });

    Future.delayed(Duration(seconds: 1),()async{

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context){
          return notesPage();
        })
      );

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color.fromRGBO(33, 31, 46, 1),
        child: Center(
            child: Hero(
                tag: "icon",
                child: FadeIn(
                  duration: Duration(milliseconds: 700),
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(top:startedAnimation==true?0:100),
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 700),
                        child: appIcon(height: 130,width: 130,)
                    )
                )
            )
            )
        ),
    );
  }
}
