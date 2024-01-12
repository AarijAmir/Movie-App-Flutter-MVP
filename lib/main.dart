import 'package:flutter/material.dart';
import 'package:movie_app/injector/casts_injector.dart';
import 'package:movie_app/injector/genres_injector.dart';
import 'package:movie_app/injector/movie_detail_injector.dart';
import 'package:movie_app/injector/movie_videos_injector.dart';
import 'package:movie_app/injector/movies_by_genre_injector.dart';
import 'package:movie_app/injector/movies_injector.dart';
import 'package:movie_app/injector/persons_injector.dart';
import 'package:movie_app/injector/similar_movies_injector.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/utils/constants.dart';

void main(List<String> args) {
  MoviesInjector().configureRepository(Flavor.production);
  MoviesByGenreInjector().configureRepository(Flavor.production);
  GenresInjector().configureRepository(Flavor.production);
  PersonsInjector().configureRepository(Flavor.production);
  MovieVideosInjector().configureRepository(Flavor.production);
  MovieDetailInjector().configureRepository(Flavor.production);
  CastsInjector().configureRepository(Flavor.production);
  SimilarMoviesInjector().configureRepository(Flavor.production);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
