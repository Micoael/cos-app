import 'package:cos_method/database/database.dart';
import 'package:cos_method/model/error.dart';
import 'package:flutter/material.dart';
class AddError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      RaisedButton(onPressed: () {
        DatabaseCollection collection = new DatabaseCollection();
        collection.insertError(
          Errors(
            id: 1,
            name: "2",
            subject: "ch",
            level: 5,
            book: 'd'
          )
        );
      },)
    );
  }
}