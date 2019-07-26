import 'package:cos_method/model/rule.dart';
import 'package:flutter/material.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final addToDosFormKey = GlobalKey<FormState>();
  String singleName;
  int singleAxis;
  //---single rule is generated.---
  String multiName;
  int multiAxis;
  List<dynamic> multiRepeatList;
  String multiStartDate;
  String multiEndDate;
  
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            Text('1'),
            Text('2'),
          ],
          title: new Text('View ToDo'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.filter_1),
              ),
              Tab(icon: Icon(Icons.filter_9_plus)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _singlePageBuilder(context),
            _multiPageBuilder(context),
          ],
        ),
      ),
      length: 2,
      initialIndex: 1,
    );
  }

  _singlePageBuilder(BuildContext context) {

    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'TODOName',
              hintText: 'Input the name of your ToDo here',
            ),
            onSaved: (value) {},
          )
        ],
      ),
    );
  }

  _multiPageBuilder(BuildContext context) {}
}
