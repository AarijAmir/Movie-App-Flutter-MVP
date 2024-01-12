class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  const Video(
      {required this.id,
      required this.key,
      required this.name,
      required this.site,
      required this.type});
  Video.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        key = map['key'],
        name = map['name'],
        site = map['site'],
        type = map['type'];
}
