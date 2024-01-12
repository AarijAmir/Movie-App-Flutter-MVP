import 'package:movie_app/data/repositories/mock/mock_movie_detail_repository.dart';
import 'package:movie_app/data/repositories/production/prod_movie_detail_repository.dart';

import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class MovieDetailInjector {
  static final MovieDetailInjector _injector = MovieDetailInjector._();
  static final _repositories = <Flavor, MovieDetailRepository>{
    Flavor.mock: const MockMovieDetailRepository(),
    Flavor.production: ProductionMovieDetailRepository(),
  };
  MovieDetailInjector._() : _flavor = Flavor.mock;
  factory MovieDetailInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  MovieDetailRepository get repository => _repositories[_flavor]!;
}
