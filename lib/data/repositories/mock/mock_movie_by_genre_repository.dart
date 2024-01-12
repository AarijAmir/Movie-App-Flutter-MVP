import 'package:movie_app/data/repositories/repository.dart';

import '../../responses/movie_response.dart';
import '../mock_movie_repository.dart';

class MockMoviesByGenreRepository extends MoviesByGenreRepository
    with MockRepository {
  const MockMoviesByGenreRepository();

  @override
  Future<MovieResponse> getMovieByGenre(int id) {
    // TODO: implement getMovieByGenre
    throw UnimplementedError();
  }
}
