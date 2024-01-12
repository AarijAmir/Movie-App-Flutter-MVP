import 'package:movie_app/data/repositories/mock/mock_genres_repository.dart';
import 'package:movie_app/data/repositories/production/prod_genres_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import '../utils/constants.dart';

class GenresInjector {
  static final GenresInjector _injector = GenresInjector._();
  static final _repositories = <Flavor, GenresRepository>{
    Flavor.mock: const MockGenreRepository(),
    Flavor.production: ProductionGenreRepository(),
  };
  GenresInjector._() : _flavor = Flavor.mock;
  factory GenresInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  GenresRepository get repository => _repositories[_flavor]!;
}
