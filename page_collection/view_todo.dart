import 'package:cos_method/model/rule.dart';
import 'package:cos_method/model/todo.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoViewer extends StatefulWidget {
  final int id;
  final List<List<ToDos>> parceledList;
  ToDoViewer(
    {this.id,
    this.parceledList}
  );

  @override
  _ToDoViewerState createState() => _ToDoViewerState();
}

class _ToDoViewerState extends State<ToDoViewer> {
  int id ;
  List<List<ToDos>> parceledList;
  @override
  Widget build(BuildContext context) {
    id = widget.id;
    if(Provider.of<UpdateManager>(context).isUpdate){
      _fetchDataWithAsync(context);
    }else{
      return _buildWithParceledData(context);
    }
    
  }

  _fetchDataWithAsync(BuildContext context){
    return FutureBuilder<List<List<ToDos>>>(
      future: ToDosAssetManager().refreshData(),
      builder: (BuildContext context, AsyncSnapshot<List<List<ToDos>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return RefreshProgressIndicator();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else{
              parceledList = snapshot.data;
              return _buildWithParceledData(context);
            }
              
        }
      },
    );
  }

  _buildWithParceledData(BuildContext context){
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
            _buildListView(0,context),
            _buildListView(1,context),
            _buildListView(2,context),
            _buildListView(3,context),
          ],
        ),
      ),
      length: 4,
      initialIndex: widget.id ,
    );
  }

  _buildListView(int index,BuildContext context) {
    List<ToDos> targetList = widget.parceledList[index];
    return ListView.builder(
      itemCount: targetList.length,
      itemBuilder: (context,position){
        return Text('${targetList[position].name}${_temp_displayText(_displayDecoder(targetList[position].rule))}');
      },
    );
  }

  _temp_displayText(ToDoRules rules){
    return "${rules.isSingle}";
  }

  _displayDecoder(String rules){
    return RulesJson.formJson(rules);
  }
}
