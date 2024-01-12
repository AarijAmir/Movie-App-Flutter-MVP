import '../models/movie.dart';

class MovieResponse {
  late List<Movie> movies;
  late String error = '';
  MovieResponse(this.error, this.movies);
  MovieResponse.fromMap(Map<String, dynamic> map)
      : movies =
            (map['results'] as List?)?.map((e) => Movie.fromMap(e)).toList() ??
                [];
  MovieResponse.withError(this.error) : movies = [];
}
