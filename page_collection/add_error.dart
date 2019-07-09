import 'package:cos_method/database/database.dart';
import 'package:cos_method/model/error.dart';
import 'package:flutter/material.dart';
class AddError extends StatelessWidget {


  _addError() async {
    DatabaseCollection collection = new DatabaseCollection();
        await collection.insertError(
          Errors(
            name: "hi",
            subject: "ch",
            level: 5,
            book: 'd'
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      RaisedButton(onPressed: () {
        _addError();
      },)
    );
  }
}