import 'package:movie_app/data/repositories/repository.dart';

import '../../responses/genre_response.dart';
import '../mock_movie_repository.dart';

class MockGenreRepository extends GenresRepository with MockRepository {
  const MockGenreRepository();

  @override
  // TODO: implement getGenres
  Future<GenreResponse> get getGenres => throw UnimplementedError();
}
