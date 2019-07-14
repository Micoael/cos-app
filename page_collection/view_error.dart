import 'package:cos_method/database/database.dart';
import 'package:cos_method/model/error.dart';
import 'package:flutter/material.dart';

class ViewErrors extends StatefulWidget{
  int id;
  int level;
  String subject;
  String book;
  String name;
  ViewErrors(Errors error){
    this.id = error.id;
    this.level = error.level;
    this.book = error.book;
    this.name = error.name;
    this.subject = error.subject;
  }
  
  @override
  _ViewErrorsState createState() => _ViewErrorsState();
}

class _ViewErrorsState extends State<ViewErrors> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Error #${widget.id}'),
          ),
        body:
          new Container(
            child:
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                  "${widget.level}✦",
                    style: new TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
                  ),
    
                  new Text(
                  "${widget.subject} - <<${widget.book}>>",
                    style: new TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
                  ),
    
                  new Text(
                  "${widget.name}",
                    style: new TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
                  )
                ]
    
              ),
    
            alignment: Alignment.center,
          ),
    
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.done),
          onPressed: fabPressed),
      );
    }

    void fabPressed() {
      DatabaseCollection collection = new DatabaseCollection();
      collection.deleteError(widget.id);
      
    }
}