class Genre {
  final int id;
  final String name;
  Genre(this.id, this.name);
  Genre.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
