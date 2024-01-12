import 'package:movie_app/data/models/cast.dart';

class CastResponse {
  final List<Cast> casts;
  final String error;
  CastResponse(this.casts, this.error);
  CastResponse.fromMap(Map<String, dynamic> map)
      : casts = (map["cast"] as List).map((i) => Cast.fromMap(i)).toList(),
        error = "";

  CastResponse.withError(String errorValue)
      : casts = [],
        error = errorValue;
}
