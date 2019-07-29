import 'package:cos_method/helper/rule_corvent.dart';
import 'package:cos_method/model/rule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final DateTime selectedDate = DateTime.now();
  //--------date---------
  final addToDosFormKey = GlobalKey<FormState>();
  final addToDosFormKey2 = GlobalKey<FormState>();
  final addRepeatFormKey = GlobalKey<FormState>();
  String singleName;
  int singleAxis;
  //---single rule is generated.---
  String multiName;
  int multiAxis;
  List<dynamic> multiRepeatList = [[0,0]];
  String multiStartDate;
  String multiEndDate = "2001-01-01";
  int duration;
  int last;


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

  _summit() {
    addToDosFormKey.currentState.save();
  }

  _selectDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (date == null) {
      return;
    } else {
      setState(() {});
      multiEndDate = date.toString().substring(0, 10);
    }
  }

  dateTimeSelection() {
    return InkWell(
      onTap: () {
        _selectDate();
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.date_range,
            color: Colors.grey,
          ),
          SizedBox(
            width: 20,
          ),
          Text("Ends at"),
          Text(DateFormat.yMMMd().format(DateTime.parse(multiEndDate))),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  _repeatSetting() {
    int duration;
    int last;

    return Form(
        key: addRepeatFormKey,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Duration',
                  hintText: 'The duration of the tips',
                ),
                onSaved: (value) {
                  duration = int.parse(value);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'Last time',
                  hintText: 'How long does it lasts?',
                ),
                onSaved: (value) {
                  last = int.parse(value);
                },
              ),
            ),
            Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('Add to list'),
                  onPressed: () {
                    addRepeatFormKey.currentState.save();
                    if (duration > 0 && last > 0) {
                      if (duration > last) {
                        multiRepeatList.add([duration, last]);
                      }
                    } else {
                      debugPrint('not right!');
                    }
                  },
                )
              ],
            )
          ],
        ));
  }

  _singlePageBuilder(BuildContext context) {
    double _piorityValue = 1;
    return Form(
      key: addToDosFormKey,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.notification_important,
            color: Colors.grey,
          ),
          Slider(
            min: 0.0,
            max: 5.0,
            value: _piorityValue,
            onChanged: (value) {
              setState(() {
                value = _piorityValue;
              });
              singleAxis = value.toInt();
            },
          ),
          Text('Axis'),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'TODOName',
                hintText: 'Input the name of your ToDo here',
              ),
              onSaved: (value) {
                singleName = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: OutlineButton(
              child: Text('OK'),
              onPressed: () {
                _summit();
              },
            ),
          ),
        ],
      ),
    );
  }

  _multiPageBuilder(BuildContext context) {
    double _piorityValue = 1;
    return Form(
      key: addToDosFormKey2,
      child: Column(
        children: <Widget>[
          //slider
          Icon(
            Icons.notification_important,
            color: Colors.grey,
          ),
          Slider(
            min: 0.0,
            max: 5.0,
            value: _piorityValue,
            onChanged: (value) {
              setState(() {
                value = _piorityValue;
              });
              multiAxis = value.toInt();
            },
          ),
          Text('Axis'),
          // todo name
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'TODOName',
              hintText: 'Input the name of your ToDo here',
            ),
            onSaved: (value) {
              multiName = value;
            },
          ),
          //end date
          dateTimeSelection(),
          //input checker

          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Duration',
                hintText: 'The duration of the tips',
              ),
              onSaved: (value) {
                duration = int.parse(value);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Last time',
                hintText: 'How long does it lasts?',
              ),
              onSaved: (value) {
                last = int.parse(value);
              },
            ),
          ),
          Row(
            children: <Widget>[
              OutlineButton(
                child: Text('Add to list'),
                onPressed: () {
                  addToDosFormKey2.currentState.save();
                  if (duration > 0 && last > 0) {
                    setState(() {});
                    if (duration > last) {
                      List<dynamic> list =[];
                      list.add([duration,last]);
                      multiRepeatList.add([duration,last]);
                      debugPrint('done!');
                      debugPrint(ToDoRules.toVisibleCharts(multiRepeatList));
                    }else{
                      debugPrint('not right!');
                    }
                  } else {
                    debugPrint('not right!');
                  }
                },
              ),
              OutlineButton(
                child: Text('Clear list'),
                onPressed: () {
                  setState(() {});
                  addToDosFormKey2.currentState.save();
                  multiRepeatList.clear();
                },
              ),
              Text(multiRepeatList == null ? "add something": ToDoRules.toVisibleCharts(this.multiRepeatList)),
            ],
          ),
            OutlineButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {});
                  addToDosFormKey2.currentState.save();
                  //TODO: Hey, Visual Studio Code, refactor me the code!
                  //TODO: wtite the database communication for me plz!
                },
              ),

            ],
          ),
          
          
    );
    
  }
}
