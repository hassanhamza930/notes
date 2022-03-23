import "package:flutter/material.dart";
import 'package:localstorage/localstorage.dart';
import 'package:notes/util/components.dart';

var storage = new LocalStorage('notes');

var titleController= TextEditingController(text: "");
var textController= TextEditingController(text: "");

class expandedNote extends StatefulWidget {
  final message;
  final title;
  final index;
  expandedNote({@required this.index,@required this.title,@required String this.message});

  @override
  _expandedNoteState createState() => _expandedNoteState();
}

class _expandedNoteState extends State<expandedNote> {

  save()async{
    await storage.ready;
    List notes=await storage.getItem("notes");
    setState(() {
      notes[widget.index]={
        "message":textController.text,
        "title":titleController.text
      };
    });
    await storage.setItem("notes", notes);
    Navigator.pop(context);
  }



  @override
  void initState() {
    titleController.text=widget.title;
    textController.text=widget.message;
    super.initState();
  }

  @override
  void dispose() {
    titleController.text="";
    textController.text="";
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 40,right: 20),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: ()async{
              await save();
            },
            child: Icon(
              Icons.done,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 31, 46,1),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(15),
            height: height*0.8,
            width: width*0.9,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
              border: Border.all(
                width: 2,
              )
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    style: customText(bold: true,size: 20.0,colora: Colors.white),
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.pink,
                  height: 1,
                  thickness: 2,
                ),
                Flexible(
                  flex: 5,
                  child: TextField(
                    maxLines: 999,
                    style: customText(size: 15.0,colora: Colors.white),
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
