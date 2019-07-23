import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  _getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  _getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomGrid()
        );
  }




}

class CustomGrid extends StatefulWidget {
  @override
  _CustomGridState createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:GridView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text('hi $index'),
          color: Colors.red,
          );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 5.5,
      ),
    )
    );
  }
}

class Center extends StatelessWidget {
  const Center({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("1"),);
  }
}
