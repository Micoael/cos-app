import 'dart:math';

import 'package:flutter/material.dart';

class Asker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Calculator Asker'),
        ),
        body: Calculate());
  }
}

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final askerKey = GlobalKey<FormState>();
  int a = 0, b = 0;
  bool isPlus = true;
  int yourResult = 0;
  int result = 0;
  String txt = "";
  @override
  Widget build(BuildContext context) {
    Random rand = Random();
    isPlus = rand.nextBool();
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$a",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                "${isPlus ? "+" : "-"}",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                "$b",
                style: TextStyle(fontSize: 30.0),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                   a=rand.nextInt(100);
                   b=rand.nextInt(100);
                   isPlus=rand.nextBool(); 
                  });
                },
                icon: Icon(Icons.replay)
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: askerKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: 'Answer',
                        hintText: 'Input the answer here!',
                      ),
                      onSaved: (value) {
                        yourResult = int.parse(value);
                      },
                    ),
                  ),
                  OutlineButton(
                      child: Text("Done"),
                      onPressed: () {
                        _summit();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _summit() {
    askerKey.currentState.save();
    if (yourResult == (isPlus ? (a + b) : (a - b))) {
      debugPrint("Yes");
      Random rand = new Random();
      a = rand.nextInt(100);
      b = rand.nextInt(100);
      setState(() {

        
      });
    } else {
      debugPrint("No");
    }
  }
}
