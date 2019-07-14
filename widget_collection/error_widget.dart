import 'package:cos_method/model/error.dart';
import 'package:cos_method/page_collection/add_error.dart';
import 'package:cos_method/page_collection/view_error.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';

class ErrorView extends StatefulWidget {
  ErrorView({Key key}) : super(key: key);
  @override
  _ErrorViewState createState() => new _ErrorViewState();
}

class ListItemGetter {
  Errors error;
  int id;
  int level;
  String subject;
  String book;
  String name;
  ListItemGetter(Errors error) {
    this.id = error.id;
    this.level = error.level;
    this.book = error.book;
    this.name = error.name;
    this.subject = error.subject;
    this.error=error;
  }

  

  Widget getWidget(Errors error,BuildContext context) {
    // return Container(
    //   child: Text("($id) \n $level※ \n $subject \n <<$book>> -- $name  "),
    // );
    return Card(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          new Text(
            "$id",
            style: new TextStyle(
                fontSize: 12.0,
                color: const Color(0xFF000000),
                ),
          ),
          new Text(
            "$level ※ $subject",
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF000000),
                ),
          ),
          new Text(
            "$name",
            style: new TextStyle(
                fontSize: 12.0,
                color: const Color(0xFF000000),
                ),
          ),
          new Text(
            "$name",
            style: new TextStyle(
                fontSize: 10.0,
                color: const Color(0x00000000)
                ),
          )
        ]
        )
        );
     
     
  }
}

class _ErrorViewState extends State<ErrorView> {

  _navigateToDetails(BuildContext context,Errors error){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => ViewErrors(error)));
  }

  //init List
  List<Errors> list;
  // init a boolean isRequested. meaning that the database was not requested before
  bool isRequested = false;
  //load database's data to List
  _commuicate() async {
    DatabaseCollection collection = new DatabaseCollection();
    //when requesting, this bool's value is true in order not to access database repeatly
    isRequested = true;
    list = new List<Errors>();
    //wait list to fetch data. When complete, tell canvas to repaint listView
    list = await collection.getAllErrors().whenComplete(() {
      //repaint
      _repaintListView();
    });
  }

  _repaintListView() {
    //build listView again in order to repaint it
    setState(() {
      build(context);
    });
  }


  List<Widget> _getListData() {
    //if requested before, aka repainting, no getting data in order to lock
    //the database
    if (!isRequested) {
      _commuicate();
    }
    //convert list to widgets in order to paint on screen
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(
        ListTile(
          onTap: ()=>_navigateToDetails(context,list[i]),
            //get the error instance to response to the click event
          title: ListItemGetter(list[i]).getWidget(list[i],context)
          )
        );
      
    }
        
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          //in order to rebuild it
          isRequested=false;
          build(context);
        },
        child: new ListView(
          children: _getListData(),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add), onPressed: fabPressed
          ),
        
      );
  }

  void fabPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => AddError()));
  }
}