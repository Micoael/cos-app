import 'package:cos_method/helper/database.dart';
import 'package:cos_method/model/error.dart';
import 'package:cos_method/model/star.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_error.dart';

class ViewErrors extends StatefulWidget {
  Errors error;
  int id;
  int level;
  String subject;
  String book;
  String name;
  ViewErrors(Errors error) {
    this.id = error.id;
    this.level = error.level;
    this.book = error.book;
    this.name = error.name;
    this.subject = error.subject;
    this.error = error;
  }

  @override
  _ViewErrorsState createState() => _ViewErrorsState();
}

class _ViewErrorsState extends State<ViewErrors> {
  _deleteErrorFromDataBase() {
    DatabaseCollection collection = new DatabaseCollection();
    collection.deleteError(widget.id);
    return collection;
  }

  @override
  Widget build(BuildContext context) {
    var isUpdate = Provider.of<UpdateManager>(context).isUpdate;
    if (isUpdate) {
      return Container(
        child: RaisedButton(
          child: Text('Updated!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Error #${widget.id}'),
        ),
        body: new Container(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "${widget.level}✦",
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new Text(
                  "${widget.subject} - <<${widget.book}>>",
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new Text(
                  "${widget.name}",
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    _deleteErrorFromDataBase();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddError(widget.error)));
                  },
                ),
                new IconButton(
                  icon: const Icon(Icons.collections_bookmark),
                  onPressed: () {
                    _deleteErrorFromDataBase().insertStar(new Stars(
                        level: widget.level,
                        subject: widget.subject,
                        book: widget.book,
                        name: widget.name));
                    Navigator.of(context).pop();
                    Provider.of<UpdateManager>(context).refresh();
                  },
                ),
              ]),
          alignment: Alignment.center,
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.done), onPressed: fabPressed),
      );
    }
  }

  void fabPressed() {
    _deleteErrorFromDataBase();
    Provider.of<UpdateManager>(context).refresh();
    Navigator.of(context).pop();
  }
}
