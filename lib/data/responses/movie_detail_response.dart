import 'package:movie_app/data/models/movie_detail.dart';

class MovieDetailResponse {
  MovieDetail? movieDetail;
  String error;
  MovieDetailResponse(this.movieDetail, this.error);
  MovieDetailResponse.fromMap(Map<String, dynamic> map)
      : movieDetail = MovieDetail.fromMap(map),
        error = '';
  MovieDetailResponse.withError(String errorValue)
      : error = errorValue,
        movieDetail = null;
}
