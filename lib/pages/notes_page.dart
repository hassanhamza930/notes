import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:localstorage/localstorage.dart';
import 'package:notes/pages/note/expanded_note.dart';
import 'package:notes/pages/note/note.dart';
import 'package:notes/util/components.dart';

var started=false;

class notesPage extends StatefulWidget {
  @override
  _notesPageState createState() => _notesPageState();
}

class _notesPageState extends State<notesPage> {


  Future<List> fetch()async{
    await storage.ready;
    var notes = storage.getItem("notes") == null ? [] : storage.getItem("notes");
    return notes;
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200),(){
      setState(() {
        started=true;
      });
    });
    super.initState();
  }


  @override
  void dispose() {
    started=false;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final storage = new LocalStorage('notes');
            var notes=snapshot.data;
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: Container(
                  padding: EdgeInsets.all(20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async {

                      List notes = await storage.getItem("notes");
                      notes = notes == null ? [] : notes;

                      notes.add({
                        "title": "New Title",
                        "message": "Message"
                      });

                      await storage.setItem("notes", notes);
                      setState(() {});

                    },
                  )),
              backgroundColor: Color.fromRGBO(33, 31, 46, 1),
              body: Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                width: width,
                height: height,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    FadeIn(
                      duration: Duration(seconds: 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "SuperNote",
                                  style: TextStyle(
                                      fontFamily: "Kufam",
                                      color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: height*0.8,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 100),
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: notes
                              .asMap()
                              .entries
                              .map((entry) {
                                int idx = entry.key;
                                Map item = entry.value;
                                return FadeIn(
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: 500 * idx),
                                  child: AnimatedContainer(
                                    margin: EdgeInsets.only(top: started==true?0:30.0*idx),
                                    duration: Duration(milliseconds: 500),
                                    child: GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(context,
                                              CupertinoPageRoute(builder: (context) {
                                                return expandedNote(
                                                  message: "${item["message"]}",
                                                  index: idx,
                                                  title: "${item["title"]}",
                                                );
                                              })).then((value)async {
                                            await setState(() {
                                            });
                                          });

                                        },
                                        child: Stack(
                                          children: [
                                            note(
                                                width: width>600?width*0.3:width * 0.45,
                                                height: 200,
                                                message: "${item["message"]}",
                                                title: "${item["title"]}"),
                                            GestureDetector(
                                              onTap: () async {
                                                List notes = await storage.getItem("notes");
                                                notes.removeAt(idx);
                                                await storage.setItem("notes", notes);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 200,
                                                width: width>600?width*0.3:width * 0.45,
                                                padding: EdgeInsets.all(10),
                                                child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black.withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(5))),
                                                      height: 50,
                                                      width: 50,
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              })
                              .toList()
                              .cast<Widget>(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
