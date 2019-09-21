import 'package:cos_method/tool_aollection/question_asker/question_asker_page.dart';
import 'package:flutter/material.dart';
class MeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView(
        children: <Widget>[
          ListTile(
            title: Text("AskyAsky"),
            subtitle: Text("Ask you about your questions and give you a mark."),
            isThreeLine: true,
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Asker()));
            },
           leading : Icon(Icons.assistant_photo,color: Colors.green,),
          ),
          ListTile(
            title: Text("Calculation Test"),
            subtitle: Text("Calculates and get marks instantly."),
            isThreeLine: true,
            onTap: (){},
           leading : Icon(Icons.unarchive,color: Colors.green,),
          ),
          ListTile(
            title: Text("Day Counter"),
            subtitle: Text("See how close it is to examine."),
            isThreeLine: true,
            onTap: (){},
           leading : Icon(Icons.timer,color: Colors.green,),
          ),
        ],
      )
    );
  }
}