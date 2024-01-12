class Movie {
  final int id;
  final double popularity;
  final String title;
  final String? backPoster;
  final String? poster;
  final String overview;
  final num rating;
  const Movie(
      {required this.backPoster,
      required this.id,
      required this.overview,
      required this.popularity,
      required this.poster,
      required this.rating,
      required this.title});

  Movie.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        popularity = map['popularity'],
        title = map['title'],
        backPoster = map['backdrop_path'],
        poster = map['poster_path'],
        overview = map['overview'],
        rating = (map['vote_average']);
}
