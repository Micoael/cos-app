class Stars{
  const Stars({
    this.id,
    this.level,
    this.book,
    this.subject,
    this.name,
});
  final int id;
  final int level;
  final String book;
  final String subject;
  final String name;

  
    Map<String, dynamic> toMap() {
    return {
      'book':book,
      'id': id,
      'name': name,
      'level': level,
      'subject' : subject
    };
  
}
}