import 'package:cos_method/database/database.dart';
import 'package:cos_method/model/star.dart';
import 'package:cos_method/model/star.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_star.dart';

class ViewStars extends StatefulWidget{
  Stars star;
  int id;
  int level;
  String subject;
  String book;
  String name;
  ViewStars(Stars star){
    this.id = star.id;
    this.level = star.level;
    this.book = star.book;
    this.name = star.name;
    this.subject = star.subject;
    this.star = star;
  }
  
  @override
  _ViewStarsState createState() => _ViewStarsState();
}

class _ViewStarsState extends State<ViewStars> {
  _deleteStarFromDataBase(){
    DatabaseCollection collection = new DatabaseCollection();
      collection.deleteStar(widget.id);
      return collection;
  }
    @override
    Widget build(BuildContext context) {
      var isUpdate = Provider.of<UpdateManager>(context).isUpdate;
    if (isUpdate) {
      return Container(
        child: RaisedButton(child: Text('Updated!'),onPressed: (){
          Navigator.of(context).pop();
        },),
      );
    }else{
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Star #${widget.id}'),
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
                  ),
                  new IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () { 
                    _deleteStarFromDataBase();
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) => AddStar(widget.star)));
                   },
                  ),
                  
                ]
    
              ),
    
            alignment: Alignment.center,
          ),
    
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.delete),
          onPressed: fabPressed),
      );
    }
      
    }

    void fabPressed() {
      _deleteStarFromDataBase();
      Provider.of<UpdateManager>(context).refresh();
      Navigator.of(context).pop();
    }
}