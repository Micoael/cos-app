import 'package:cos_method/model/rule.dart';
import 'package:cos_method/model/todo.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:cos_method/page_collection/view_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_todo.dart';

class ToDoViewer extends StatefulWidget {
  final int id;
  final List<List<ToDos>> parceledList;
  ToDoViewer({this.id, this.parceledList});

  @override
  _ToDoViewerState createState() => _ToDoViewerState();
}

class _ToDoViewerState extends State<ToDoViewer> {
  int id=0;
  List<List<ToDos>> parceledList;
  @override
  Widget build(BuildContext context) {
     id = widget.id;
    if (Provider.of<UpdateManager>(context).isUpdate) {
      Provider.of<UpdateManager>(context).understood();
      return _fetchDataWithAsync(context);
    } else {
      return _buildWithParceledData(context);
    }
    
  }

  _fetchDataWithAsync(BuildContext context) {
    return FutureBuilder<List<List<ToDos>>>(
      future: ToDosAssetManager().refreshData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<List<ToDos>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return RefreshProgressIndicator();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              parceledList = snapshot.data;
              return _buildWithParceledData(context);
            }
        }
      },
    );
  }

  _buildWithParceledData(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            Text('1'),
            Text('2'),
            Text('3'),
            Text('4'),
          ],
          title: new Text('View ToDo'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "1",
              ),
              Tab(
                text: "2",
              ),
              Tab(
                text: "3",
              ),
              Tab(
                text: "4",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildListView(0, context),
            _buildListView(1, context),
            _buildListView(2, context),
            _buildListView(3, context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddToDoPage()));
          },
        ),
      ),
      length: 4,
      initialIndex: widget.id,
    );
  }

  _buildListView(int index, BuildContext context) {
    debugPrint('execute repaint at view_todo!');
    List<ToDos> targetList=[];
    if(widget.parceledList!=null){
      targetList = ToDoItemFilter().clean(widget.parceledList)[index];
      return ListView.builder(
      itemCount: targetList.length,
      itemBuilder: (context, position) {
        return _buildGridGraph(index, context, targetList, position);
        // return Text(
        //     '${targetList[position].name}${_temp_displayText(_displayDecoder(targetList[position].rule))}');
      },
    );
    }else{
      return new Text("add first!");
    }
    
   
  }

  _temp_displayText(ToDoRules rules) {
    return "${rules.isSingle}";
  }

  _displayDecoder(String rules) {
    return RulesJson.formJson(rules);
  }

  _buildGridGraph(int index, BuildContext context,List<ToDos> targetList,int position){
    // a single builder...
    return InkWell(
      child: 
        Card(
          child: Container(
            alignment: Alignment.center,
            child: Text("[${targetList[position].id}] => ${targetList[position].name}"),
          ),
        ),
      onTap: (){
        ToDos todo = targetList[position];
         Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewToDoItem(id: todo.id,name: todo.name,rule: todo.rule,piority: todo.piority,)));
      },
    );
  }



}



class ToDoItemFilter{
    List<List<ToDos>> cleaned =[];
   
   clean(List<List<ToDos>> toBeCleaned){
    for (var i = 0; i < 5; i++) {
      List<ToDos> todos = [];
      for (var j = 0; j < toBeCleaned[i].length; j++) {
         
        if(PraseNewToDo().isDisplayToday(toBeCleaned[i][j])){
          todos.add(toBeCleaned[i][j]);
        }
      }
      final List<ToDos> q = todos;
      cleaned.add(q);
      todos = [];
    }
   
    return cleaned;
  }
}