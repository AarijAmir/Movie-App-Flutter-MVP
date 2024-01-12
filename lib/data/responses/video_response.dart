import 'package:movie_app/data/models/video.dart';

class VideoResponse {
  final List<Video> videos;
  final String error;
  VideoResponse(this.error, this.videos);
  VideoResponse.fromMap(Map<String, dynamic> map)
      : videos = (map['results'] as List).map((e) => Video.fromMap(e)).toList(),
        error = '';
  VideoResponse.withError(String errorValue)
      : error = errorValue,
        videos = [];
}
