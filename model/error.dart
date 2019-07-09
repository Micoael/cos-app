class Errors{
  const Errors({
    this.id,
    this.level,
    this.subject,
    this.book,
    this.name,
});
  final int id;
  final int level;
  final String subject;
  final String book;
  final String name;

  
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'book':book,
      'level': level,
      'subject' : subject
    };
  
}
}