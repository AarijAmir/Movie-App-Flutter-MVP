import '../data/repositories/mock/mock_movie_by_genre_repository.dart';
import '../data/repositories/production/prod_movie_by_genre_repository.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class MoviesByGenreInjector {
  static final MoviesByGenreInjector _injector = MoviesByGenreInjector._();
  static final _repositories = <Flavor, MoviesByGenreRepository>{
    Flavor.mock: const MockMoviesByGenreRepository(),
    Flavor.production: ProductionMoviesByGenreRepository(),
  };
  MoviesByGenreInjector._() : _flavor = Flavor.mock;
  factory MoviesByGenreInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  MoviesByGenreRepository get repository => _repositories[_flavor]!;
}
