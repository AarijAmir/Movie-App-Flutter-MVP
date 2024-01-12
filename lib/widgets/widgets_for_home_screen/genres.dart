import 'package:flutter/material.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/modules/genres_presenter.dart';

import '../elements/error_element.dart';
import '../elements/loading_element.dart';
import 'genres_list.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> with GenresListContract {
  late GenresListPresenter? _genresListPresenter;
  List<Genre> _genresList = [];
  bool _isStartLoading = true;
  String _errorMessage = '';
  _GenresScreenState() {
    _genresListPresenter = GenresListPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genresListPresenter?.loadGenres();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (_isStartLoading)
        ? SizedBox(
            height: size.height * 0.8,
            width: size.width,
            child: Center(
              child: buildLoadingWidget(
                size,
              ),
            ),
          )
        : (_isStartLoading == false &&
                _errorMessage.isNotEmpty &&
                _genresList.isEmpty)
            ? buildErrorWidget(_errorMessage)
            : _buildGenresWidget(_genresList);
  }

  Widget _buildGenresWidget(List<Genre> genresList) {
    return (genresList.isEmpty)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                "No More Movies",
                style: TextStyle(color: Colors.black45),
              ),
            ),
          )
        : GenresList(list: genresList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _genresListPresenter = null;
    super.dispose();
  }

  @override
  void onLoadGenresCompleteWithSuccess(List<Genre> genresList) {
    // TODO: implement onLoadGenresCompleteWithSuccess
    setState(() {
      _genresList = genresList;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadGenresWithError(String errorMessage) {
    // TODO: implement onLoadGenresWithError
    _errorMessage = errorMessage;
    _isStartLoading = false;
    _genresList = [];
  }
}
