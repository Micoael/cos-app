class Questions{
  const Questions({
    this.id,
    this.level,
    this.subject,
    this.name,
});
  final int id;
  final int level;
  final String subject;
  final String name;

  
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'subject' : subject
    };
  
}
}