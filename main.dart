import 'package:cos_method/notifier/update_schedule.dart';
import 'package:cos_method/widget_collection/error_widget.dart';
import 'package:cos_method/widget_collection/star_widget.dart';
import 'package:cos_method/widget_collection/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<UpdateManager>.value(value: UpdateManager(false)),
      Provider<ToDosAssetManager>.value(value: ToDosAssetManager(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'COS App',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        // canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  void _onTapHandler(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      ErrorView(),
      StarView(),
      ToDoWidget(),
      null,
      //TODO: Make the following 4 steps
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('cosAPP'),
      ),
      body: widgetList[_selectedItem],
      bottomNavigationBar: new BottomNavigationBar(
          onTap: _onTapHandler,
          fixedColor: Colors.green,
          unselectedItemColor: Colors.green[800],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedItem,
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.error),
              title: new Text('Error'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              title: new Text('Favorite'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.router),
              title: new Text('TODO'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              title: new Text('Me'),
            )
          ]),
    );
  }
}
