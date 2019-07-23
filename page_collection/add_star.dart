import 'package:cos_method/helper/database.dart';
import 'package:cos_method/model/star.dart';
import 'package:cos_method/notifier/update_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStar extends StatefulWidget {
  Stars star;
  AddStar(Stars star) {
    if (star == null) {
      star = new Stars(
        id: 0,
        level: 4,
        book: "",
        subject: "",
        name: "",
      );
    } else {
      this.star = star;
    }
  }
  @override
  _AddStarState createState() => _AddStarState();
}

class _AddStarState extends State<AddStar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Star'),
        ),
        body: Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.green),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[AddStarForm(widget.star)],
              ),
            )));
  }
}

class AddStarForm extends StatefulWidget {
  Stars star;
  AddStarForm(Stars star) {
    if (star == null) {
      star = new Stars(
        id: 0,
        level: 4,
        book: "",
        subject: "",
        name: "",
      );
    } else {
      this.star = star;
    }
  }

  @override
  _AddStarFormState createState() => _AddStarFormState();
}

class _AddStarFormState extends State<AddStarForm> {
  final addStarFormKey = GlobalKey<FormState>();
  String subject, book, name;
  int piority;
  double _piorityValue = 0;

  _addStar(String name, subject, book, int level) async {
    DatabaseCollection collection = new DatabaseCollection();
    await collection.insertStar(Stars(
        name: this.name,
        subject: this.subject,
        level: this.piority,
        book: this.book));
  }

  _summit() {
    addStarFormKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addStarFormKey,
      child: Column(
        children: <Widget>[
          Container(
              child: Row(
            children: <Widget>[
              Icon(
                Icons.notification_important,
                color: Colors.grey,
              ),
              Slider(
                label: _piorityValue.toString() + "✦",
                min: 0.0,
                max: 5.0,
                value: _piorityValue,
                onChanged: (value) {
                  setState(() {
                    _piorityValue = value;
                  });
                  piority = value.toInt();
                },
              ),
              Text('level of importance')
            ],
          )),
          TextFormField(
            initialValue: widget.star.subject,
            decoration: InputDecoration(
              icon: Icon(Icons.subject),
              labelText: 'Subjects',
              hintText: 'Input your subjects here',
            ),
            onSaved: (value) {
              subject = (value.length == 0) ? "blank" : value;
            },
          ),
          //TODO:build subject chip
          TextFormField(
            initialValue: widget.star.book,
            decoration: InputDecoration(
              icon: Icon(Icons.book),
              labelText: 'Book',
              hintText: 'Input your book here',
            ),
            onSaved: (value) {
              book = (value.length == 0) ? "blank" : value;
            },
          ),
          TextFormField(
            initialValue: widget.star.name,
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'Description',
              hintText: 'Input your description here',
            ),
            onSaved: (value) {
              name = (value.length == 0) ? "blank" : value;
            },
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: OutlineButton(
              child: Text('OK'),
              onPressed: () {
                _summit();
                _addStar(name, subject, book, piority);
                Provider.of<UpdateManager>(context).refresh();
                debugPrint("$piority and $subject and $name and $book");
                Navigator.of(context).pop();
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
            Chip(
              label: Text("CHN"),
              onDeleted: () {},
            ),
            Chip(
              label: Text("MAT"),
            ),
            Chip(
              label: Text("ENG"),
            ),
            Chip(
              label: Text("POL"),
            ),
            Chip(
              label: Text("HIS"),
            ),
            Chip(
              label: Text("PHY"),
            ),
            Chip(
              label: Text("CHE"),
            ),
            Chip(
              label: Text("BIO"),
            ),
            Chip(
              label: Text("COM"),
            ),
          ],
        ),
      ),
    );
  }
}
