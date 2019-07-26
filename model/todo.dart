import 'package:cos_method/model/rule.dart';

class ToDos{
  const ToDos({
    this.id,
    this.piority,
    this.rule,
    this.name,
});
  final int id;
  final int piority;
  final String rule;
  final String name;

  
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rule': rule,
      'piority' : piority
    };
  
}
}


class PraseNewToDo{
  toObject(ToDos toDo){
    String ruleText = toDo.rule;
    ToDoRules rules = RulesJson.formJson(ruleText);
    return rules;
  }

  /// returns a `bool` value. Indicates whether or not it will be shown
  /// on the screeen.
  /// How to use?
  /// ```
  /// //just a sample. You can generate yours.
  /// ToDoRules rulez = new ToDoRules(
  ///     isSingle:false,
  ///      startTime:"2019-07-21",
  ///      endTime:"2019-09-25", 
  ///     repeat:[[2,2],[3,1]]);
  ///  rulez.setDone(rulez);
  ///  String rules = RulesJson.getJson(rule: rulez);
  ///  ToDos tds = new ToDos(
  ///   id: 0,
  ///    piority: 4,
  ///    rule:rules,
  ///    name:'hi'
  ///  );
  ///  bool bl = PraseNewToDo().isDisplayToday(tds);
  ///  debugPrint('$bl');
  /// ```

  isDisplayToday(ToDos toDo){
    DisplayToDoList dtl = new DisplayToDoList();
    return dtl.getIsDisplayToDoList(toObject(toDo));
  }
}