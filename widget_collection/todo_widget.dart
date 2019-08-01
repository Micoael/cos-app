import 'package:cos_method/helper/database.dart';
import 'package:cos_method/helper/get_todo_name.dart';
import 'package:cos_method/model/todo.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:cos_method/page_collection/add_todo.dart';
import 'package:cos_method/page_collection/view_todo.dart';
import 'package:flutter/material.dart';

class ToDoWidget extends StatefulWidget {
  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  List<List<ToDos>> parceledList=[];
    static String testRule = '{"isSingle":false,"startTime":"2019-07-21","endTime":"2019-07-22","repeat":[[2,2],[3,1]],"lastDoneDate":"2019-07-25"}';
    static ToDos tds = new ToDos(
      piority: 1,
      rule:testRule,
      name:'hi'
    );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<ToDos>>>(
      future: ToDosAssetManager().refreshData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else{
              List<List<ToDos>> i = snapshot.data;
              parceledList = snapshot.data;
              return showMainMenu(context,snapshot);
            }
              
        }
      },
    );
  }


  showMainMenu(BuildContext context, AsyncSnapshot<List<List<ToDos>>> snapshot){
    List<ToDos> list0 = snapshot.data[0];
    List<ToDos> list1 = snapshot.data[1];
    List<ToDos> list2 = snapshot.data[2];
    List<ToDos> list3 = snapshot.data[3];
    List<ToDos> listDefault = snapshot.data[4];
    int allCount = list0.length+list1.length+list2.length+list3.length+listDefault.length;
    
    return Container(
      child:
        Column(children: <Widget>[
            FlatButton(child: Text("${GetToDoName().getToDoName(0)}(${list0.length/allCount})") ,
              onPressed:(){_viewToDos(0);} ,
            ),
            FlatButton(child: Text("${GetToDoName().getToDoName(1)}(${list1.length/allCount})") ,
              onPressed:(){_viewToDos(1);} ,
            ),
            FlatButton(child: Text("${GetToDoName().getToDoName(2)}(${list2.length/allCount})") ,
              onPressed:(){_viewToDos(2);} ,
            ),
            FlatButton(child: Text("${GetToDoName().getToDoName(3)}(${list3.length/allCount})") ,
              onPressed:(){_viewToDos(3);} ,
            ),
            FlatButton(child: Text("${GetToDoName().getToDoName(4)}(${listDefault.length/allCount})") ,
              onPressed:(){_tryAdd();} ,
            ),
        ],
        )
    );
  }

  _viewToDos(int id){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ToDoViewer(id:id,parceledList: parceledList,)));
  }


  _tryAdd(){
   
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => AddToDoPage()));
  }
}

