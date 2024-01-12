import 'package:movie_app/data/repositories/repository.dart';

import '../../responses/movie_response.dart';
import '../mock_movie_repository.dart';

class MockMoviesRepository extends MoviesRepository with MockRepository {
  const MockMoviesRepository();
  @override
  // TODO: implement getMovies
  Future<MovieResponse> get getMovies async => throw '';
}
