import 'package:cos_method/page_collection/add_error.dart';
import 'package:cos_method/widget_collection/error_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'COS App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
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
    void _onTapHandler(int index){
      setState(() {
       _selectedItem = index; 
      });
    }
    @override
    Widget build(BuildContext context) {
      final List<Widget> widgetList = [
        ErrorView(),
        null,
        null,
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
          fixedColor: Colors.blueAccent,
          backgroundColor: Colors.lightBlue,
          unselectedItemColor: Colors.lightBlue,
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedItem,
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.error),
              title: new Text('Error'),
              
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.question_answer),
              title: new Text('Questions'),
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.router),
              title: new Text('TODO'),
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              title: new Text('Me'),
            )
          ]
    
        ),
      );
    }
}