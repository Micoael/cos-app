import 'package:cos_method/database/database.dart';
import 'package:cos_method/model/error.dart';
import 'package:flutter/material.dart';

class AddError extends StatelessWidget {

  

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child:
  //     RaisedButton(onPressed: () {
  //       _addError();
  //     },)
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Add Error'),
        ),
        body: Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.blue),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[AddErrorForm()],
              ),
            )));
  }
}

class AddErrorForm extends StatefulWidget {
  @override
  _AddErrorFormState createState() => _AddErrorFormState();
}

class _AddErrorFormState extends State<AddErrorForm> {
  final addErrorFormKey = GlobalKey<FormState>();
  String subject,book,name;
  int piority;
  double _piorityValue=1.0;

  _addError(String name,subject,book , int level) async {
      DatabaseCollection collection = new DatabaseCollection();
      await collection
          .insertError(
            Errors(
                name: this.name,
                subject: this.subject,
                level: this.piority, 
                book: this.book
              )
          );
    }

  _summit(){
    addErrorFormKey.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: addErrorFormKey,
      child: Column(
        children: <Widget>[
          Container(
            child:Row(
              children: <Widget>[
                Icon(Icons.notification_important,color: Colors.grey,),
                Slider(
                  label: _piorityValue.toString() + "✦",
                  min: 0.0,
                  max: 5.0,
                  value: _piorityValue,
                  onChanged: (value){
                    setState(() {
                    _piorityValue=value; 
                    });
                    piority=value.toInt();
                    },
                  ),
                  Text('level of importance')
              ],
            )
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.subject),
              labelText: 'Subjects',
              hintText: 'Input your subjects here',
            ),
            onSaved: (value){
              subject=value;
              },
          ),
          //TODO:build subject chip
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.book),
              labelText: 'Book',
              hintText: 'Input your book here',
            ),
            onSaved: (value){
              book=value;
              },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'Description',
              hintText: 'Input your description here',
            ),
            onSaved: (value){
              name=value;
              },
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: OutlineButton(
              child: Text('OK'), 
              onPressed: () {
                _summit();
                _addError(name, subject, book, piority);
                debugPrint("$piority and $subject and $name and $book");
              },
            ),
          ),
      ],
      ),
    );
  }
}

class SubjectChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Chip(label: Text("CHN"),
          onDeleted: (){},
          ),
          Chip(label: Text("MAT"),
          ),
          Chip(label: Text("ENG"),
          ),
          Chip(label: Text("POL"),
          ),
          Chip(label: Text("HIS"),
          ),
          Chip(label: Text("PHY"),
          ),
          Chip(label: Text("CHE"),
          ),
          Chip(label: Text("BIO"),
          ),
          Chip(label: Text("COM"),
          ),
          
        ],
      ),
      ),
    );
  }
}