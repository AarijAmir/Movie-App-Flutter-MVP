import 'package:dio/dio.dart';
import 'package:movie_app/data/responses/cast_response.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';
import 'package:movie_app/data/responses/video_response.dart';
import 'package:movie_app/exceptions/fetch_data_exception.dart';

import '../../utils/constants.dart';
import '../responses/genre_response.dart';
import '../responses/movie_response.dart';
import '../responses/person_reponse.dart';

class MovieAPI {
  final Dio _dio = Dio();
  MovieAPI() {
    _dio.options.baseUrl = mainURL;
  }
  Future<MovieResponse> getMovies() async {
    Map<String, dynamic> params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    };
    try {
      Response response = await _dio.get(popularURL, queryParameters: params);

      if (response.isSuccessful) {
        return MovieResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on DioError {
      return MovieResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return MovieResponse.withError('Something Went Wrong');
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};
    try {
      Response response = await _dio.get(playingURL, queryParameters: params);
      if (response.isSuccessful) {
        return MovieResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on DioError {
      print('Socket Exception Is Called...');
      return MovieResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return MovieResponse.withError('Something Went Wrong');
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};
    try {
      Response response = await _dio.get(genresURL, queryParameters: params);
      if (response.isSuccessful) {
        return GenreResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on DioError {
      return GenreResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return GenreResponse.withError('Something Went Wrong');
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {'api_key': apiKey};
    try {
      Response response = await _dio.get(personURL, queryParameters: params);
      if (response.isSuccessful) {
        return PersonResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on DioError {
      return PersonResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return PersonResponse.withError('Something Went Wrong');
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id
    };
    try {
      Response response =
          await _dio.get(movieWithGenreURL, queryParameters: params);
      if (response.isSuccessful) {
        return MovieResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on NetworkException catch (e) {
      return MovieResponse.withError(e.toString());
    } on DioError {
      return MovieResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return MovieResponse.withError('Something Went Wrong');
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {'api_key': apiKey, 'language': 'en-US'};

    try {
      Response response =
          await _dio.get('$movieUrl/$id', queryParameters: params);
      if (response.isSuccessful) {
        return MovieDetailResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on NetworkException catch (e) {
      return MovieDetailResponse.withError(e.toString());
    } on DioError {
      return MovieDetailResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return MovieDetailResponse.withError('Something Went Wrong');
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {'api_key': apiKey, 'language': 'en-US'};
    try {
      Response response =
          await _dio.get('$movieUrl/$id/credits', queryParameters: params);
      if (response.isSuccessful) {
        return CastResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on NetworkException catch (e) {
      return CastResponse.withError(e.toString());
    } on DioError {
      return CastResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return CastResponse.withError('Something Went Wrong');
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {'api_key': apiKey, 'language': 'en-US'};
    try {
      Response response =
          await _dio.get('$movieUrl/$id/similar', queryParameters: params);
      if (response.isSuccessful) {
        return MovieResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on NetworkException catch (e) {
      return MovieResponse.withError(e.toString());
    } on DioError {
      return MovieResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return MovieResponse.withError('Something Went Wrong');
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {'api_key': apiKey, 'language': 'en-US'};
    try {
      print('Calledieee');
      Response response =
          await _dio.get('$movieUrl/$id/videos', queryParameters: params);

      if (response.isSuccessful) {
        return VideoResponse.fromMap(response.data);
      }
      throw response.whyNotSuccessfulResponse();
    } on NetworkException catch (e) {
      return VideoResponse.withError(e.toString());
    } on DioError {
      return VideoResponse.withError('Check Your Internet Connection');
    } catch (e) {
      return VideoResponse.withError('Something Went Wrong');
    }
  }
}

extension SuccessfulResponse on Response {
  bool get isSuccessful => statusCode == 200;

  NetworkException whyNotSuccessfulResponse() {
    switch (statusCode) {
      case 400:
        throw BadRequestException('Bad Request');
      case 500:
      case 404:
        throw UnauthorizedException('UnAuthorized Exception');
      default:
        throw FetchDataException(
            'Error Occurred While Communicating With Server'
            'with status code');
    }
  }
}
