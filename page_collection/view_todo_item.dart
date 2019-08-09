import 'package:cos_method/helper/database.dart';
import 'package:cos_method/model/rule.dart';
import 'package:cos_method/model/todo.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:cos_method/page_collection/add_todo.dart';
import 'package:cos_method/page_collection/view_todo.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ViewToDoItem extends StatefulWidget {
  final int id;
  final String rule;
  final int piority;
  final String name;
  ViewToDoItem({this.id, this.name, this.piority, this.rule});
  @override
  _ViewToDoItemState createState() => _ViewToDoItemState();
}

class _ViewToDoItemState extends State<ViewToDoItem> {
  ToDos obj;
  @override
  Widget build(BuildContext context) {
    ToDos tds = new ToDos(
        id: widget.id,
        rule: widget.rule,
        name: widget.name,
        piority: widget.piority);
    obj = tds;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ToDo #${widget.id}'),
      ),
      body: new Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "${widget.piority}✦",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new Text(
                "${widget.name} ",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new Text(
                "${widget.rule}",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  _deleteToDoFromDataBase();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddToDoPage()));
                },
              ),
            ]),
        alignment: Alignment.center,
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.done), onPressed: setToDoAsDone),
    );
  }

  void setToDoAsDone() async {
    if(RulesJson.formJson(obj.rule).isSingle){
      _deleteToDoFromDataBase();
      Navigator.of(context).pop();
      Provider.of<UpdateManager>(context).refresh();
    }else{
      ToDos updatedToDo = ToDos(
        id: obj.id,
        name: obj.name,
        rule: RulesJson.getJson(
            rule: RulesJson.formJson(obj.rule)
                .setDone(RulesJson.formJson(obj.rule))),
        piority: obj.piority);
    DatabaseCollection db = new DatabaseCollection();
    await db.updateToDo(updatedToDo).whenComplete(() {
      Provider.of<UpdateManager>(context).refresh();
      Navigator.of(context).pop();
    });
    }
  }

  DatabaseCollection _deleteToDoFromDataBase() {
    DatabaseCollection db = new DatabaseCollection();
    db.deleteToDo(obj.id);
    return db;
  }
}
