import 'package:movie_app/data/models/genre.dart';

class MovieDetail {
  final int? id;
  final bool adult;
  final int? budget;
  final List<Genre> genres;
  final String? releaseDate;
  final int? runTime;
  MovieDetail(
      {required this.adult,
      required this.budget,
      required this.genres,
      required this.id,
      required this.releaseDate,
      required this.runTime});
  MovieDetail.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        adult = map['adult'],
        budget = map['budget'],
        genres = (map['genres'] as List).map((e) => Genre.fromMap(e)).toList(),
        releaseDate = map['release_date'],
        runTime = map['runtime'];
}
