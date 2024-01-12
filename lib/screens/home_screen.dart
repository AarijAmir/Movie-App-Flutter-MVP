import 'package:flutter/material.dart';
import 'package:movie_app/style/theme/theme.dart';
import 'package:movie_app/widgets/widgets_for_home_screen/now_playing.dart';

import '../widgets/widgets_for_home_screen/genres.dart';
import '../widgets/widgets_for_home_screen/top_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text('Movie App'),
      ),
      body: ListView(
        children: const [
          NowPlaying(),
          GenresScreen(),
          TopMovies(),
        ],
      ),
    );
  }
}
