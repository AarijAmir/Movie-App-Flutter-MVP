import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_detail.dart';
import 'package:movie_app/modules/movie_detail_presenter.dart';
import 'package:movie_app/style/theme/theme.dart';

import '../elements/error_element.dart';
import '../elements/loading_element.dart';

class MovieInformation extends StatefulWidget {
  const MovieInformation({super.key, required this.id});
  final int id;

  @override
  State<MovieInformation> createState() => _MovieInformationState();
}

class _MovieInformationState extends State<MovieInformation>
    with MovieDetailContract {
  MovieDetailPresenter? _moviesDetailPresenter;
  MovieDetail? _movieDetail;
  bool _isStartLoading = true;
  String _errorMessage = '';
  _MovieInformationState() {
    _moviesDetailPresenter = MovieDetailPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moviesDetailPresenter?.loadMovieDetail(widget.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _moviesDetailPresenter = null;
    super.dispose();
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
                _movieDetail == null)
            ? buildErrorWidget(_errorMessage)
            : _buildInformationWidget(_movieDetail!);
  }

  Widget _buildInformationWidget(MovieDetail movieDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BUDGET',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${movieDetail.budget}\$',
                    style: const TextStyle(
                      color: secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DURATION',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${movieDetail.runTime} min',
                    style: const TextStyle(
                      color: secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RELEASE DATE',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    movieDetail.releaseDate ?? '',
                    style: const TextStyle(
                      color: secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GENRES',
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 30.0,
                padding: const EdgeInsets.only(
                  top: 5.0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieDetail.genres.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      padding: const EdgeInsets.all(
                        5.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            5.0,
                          ),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        movieDetail.genres[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 9.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void onLoadMoviesDetailCompleteWithSuccess(MovieDetail movieDetail) {
    // TODO: implement onLoadMoviesDetailCompleteWithSuccess
    setState(() {
      _movieDetail = movieDetail;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadMoviesDetailWithError(String errorMessage) {
    // TODO: implement onLoadMoviesDetailWithError
    setState(() {
      _movieDetail = null;
      _isStartLoading = false;
      _errorMessage = errorMessage;
    });
  }
}
