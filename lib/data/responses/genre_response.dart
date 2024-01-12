import '../models/genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse(this.genres, this.error);

  GenreResponse.fromMap(Map<String, dynamic> map)
      : genres = (map["genres"] as List).map((i) => Genre.fromMap(i)).toList(),
        error = "";

  GenreResponse.withError(String errorValue)
      : genres = [],
        error = errorValue;
}
