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