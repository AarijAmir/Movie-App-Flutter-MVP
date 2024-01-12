import '../data/repositories/mock/mock_movies_repository.dart';
import '../data/repositories/production/prod_movies_repository.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class MoviesInjector {
  static final MoviesInjector _injector = MoviesInjector._();
  static final _repositories = <Flavor, MoviesRepository>{
    Flavor.mock: const MockMoviesRepository(),
    Flavor.production: ProductionMoviesRepository(),
  };
  MoviesInjector._() : _flavor = Flavor.mock;
  factory MoviesInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  MoviesRepository get repository => _repositories[_flavor]!;
}
