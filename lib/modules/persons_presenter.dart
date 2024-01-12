import 'package:movie_app/data/models/person.dart';

import '../data/repositories/repository.dart';
import '../injector/persons_injector.dart';

abstract class PersonsListContract {
  void onLoadPersonsCompleteWithSuccess(List<Person> personsList);
  void onLoadPersonsWithError(String errorMessage);
}

class PersonsListPresenter {
  final PersonsListContract _view;
  final PersonsRepository _personsRepository;
  PersonsListPresenter(this._view)
      : _personsRepository = PersonsInjector().repository;
  void loadPersons() async {
    _personsRepository.getPersons.then((value) {
      if (value.error.isEmpty) {
        _view.onLoadPersonsCompleteWithSuccess(value.persons);
      } else {
        _view.onLoadPersonsWithError(value.error);
      }
    }).onError((error, stackTrace) {
      _view.onLoadPersonsWithError(error.toString());
    });
  }
}
