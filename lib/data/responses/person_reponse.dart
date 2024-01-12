import '../models/person.dart';

class PersonResponse {
  late final List<Person> persons;
  late final String error;
  PersonResponse(this.error, this.persons);
  PersonResponse.fromMap(Map<String, dynamic> map)
      : persons =
            (map['results'] as List).map((e) => Person.fromMap(e)).toList(),
        error = '';
  PersonResponse.withError(this.error) : persons = [];
}
