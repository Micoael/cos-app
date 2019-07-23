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

  isDisplayToday(ToDos toDo){
    DisplayToDoList dtl = new DisplayToDoList();
    return dtl.getIsDisplayToDoList(toObject(toDo));
  }
}