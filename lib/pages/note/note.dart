import 'package:flutter/material.dart';
import 'package:notes/util/components.dart';



class note extends StatefulWidget {
  final String title;
  final String message;
  final double width;
  final double height;
  note({@required this.width,@required this.height,@required this.message,@required this.title});


  _noteState createState() => _noteState();
}

class _noteState extends State<note> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      height: double.parse("${widget.height}"),
      width: double.parse("${widget.width}"),
      decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.8),
          borderRadius: BorderRadius.all(
          Radius.circular(8)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 1,child: Text("${widget.title}",maxLines: 1,overflow: TextOverflow.clip,style: customText(size: 18.0,bold: true,colora: Colors.white),)),
          SizedBox(height: 2,),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.white,
          ),
          SizedBox(height: 10,),
          Flexible(flex: 4,child: Text("${widget.message}",overflow: TextOverflow.fade,style: customText(size: 15.0,colora: Colors.white.withOpacity(0.85)),)),
        ],
      ),
    );
  }
}
