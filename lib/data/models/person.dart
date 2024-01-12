class Person {
  final int id;
  final double popularity;
  final String name;
  final String? profileImg;
  final String known;

  Person(this.id, this.popularity, this.name, this.profileImg, this.known);

  Person.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        popularity = map["popularity"],
        name = map["name"],
        profileImg = map["profile_path"],
        known = map["known_for_department"];
}
