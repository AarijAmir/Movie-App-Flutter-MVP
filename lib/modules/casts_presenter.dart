import 'package:movie_app/data/responses/cast_response.dart';
import 'package:movie_app/injector/casts_injector.dart';

import '../data/models/cast.dart';
import '../data/repositories/repository.dart';
import '../exceptions/fetch_data_exception.dart';

abstract class CastsListContract {
  void onLoadCastsCompleteWithSuccess(List<Cast> castList);
  void onLoadCastsWithError(String errorMessage);
}

class CastsListPresenter {
  final CastsListContract _view;
  final CastsRepository _castsRepository;
  CastsListPresenter(this._view)
      : _castsRepository = CastsInjector().repository;
  void loadGenres(int id) async {
    try {
      CastResponse castResponse = await _castsRepository.getCasts(id);
      print('${castResponse.error}Result');
      // await Future.delayed(const Duration(seconds: 2));
      if (castResponse.error.isEmpty) {
        _view.onLoadCastsCompleteWithSuccess(castResponse.casts);
      } else {
        _view.onLoadCastsWithError(castResponse.error);
      }
    } on NetworkException catch (e) {
      _view.onLoadCastsWithError(e.message);
    } catch (e) {
      _view.onLoadCastsWithError(e.toString());
    }
  }
}
