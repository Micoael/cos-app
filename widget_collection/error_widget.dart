import 'package:cos_method/model/error.dart';
import 'package:cos_method/page_collection/add_error.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';

class ErrorView extends StatefulWidget {
  ErrorView({Key key}) : super(key: key);
  @override
  _ErrorViewState createState() => new _ErrorViewState();
}


class ListItemGetter {
  int id;
  int level;
  String subject;
  String book;
  String name;
  ListItemGetter(Errors error){
    this.id=error.id;
    this.level=error.level;
    this.book=error.book;
    this.name=error.name;
    this.subject=error.subject;
  }

  Widget getWidget() {
    return Container(
      child: Text("($id) $level※ $subject <<$book>> -- $name  "),
    );
  }
}



class _ErrorViewState extends State<ErrorView> {
  List<Errors> list;
  bool isRequested=false;
  _commuicate() async{
    DatabaseCollection collection = new DatabaseCollection();
    isRequested=true;
    list = new List<Errors>();
    
    list = await collection.getAllErrors().whenComplete(
        (){
          _repaintListView();
        }
      );
    
    
  }

  _repaintListView(){
    setState(() {
     build(context); 
    });
  }


  List<Widget> _getListData(){
    if(!isRequested){
       _commuicate();
    }
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(Padding(
          padding: EdgeInsets.all(10.0), 
          child: ListItemGetter(list[i]).getWidget()
        )
        );
    }
    return widgets;
  }
    @override
    Widget build(BuildContext context){
      return new Scaffold(
        body:  new ListView(
          children: _getListData(),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: fabPressed),
      );
    }
    void fabPressed() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context)=> AddError())
      );
    }
    
}