import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/genre_response.dart';

import '../production_movie_repository.dart';

class ProductionGenreRepository extends GenresRepository
    with ProductionRepository {
  @override
  // TODO: implement getGenres
  Future<GenreResponse> get getGenres async => await movieAPI.getGenres();
}
