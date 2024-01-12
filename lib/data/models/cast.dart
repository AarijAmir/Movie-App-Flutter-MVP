class Cast {
  final int id;
  final String? character;
  final String? name;
  final String? img;
  Cast({
    required this.character,
    required this.id,
    required this.img,
    required this.name,
  });
  Cast.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        character = map['character'],
        name = map['name'],
        img = map['profile_path'];
}
