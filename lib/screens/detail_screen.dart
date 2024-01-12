import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/models/video.dart';
import 'package:movie_app/modules/movie_videos_presenter.dart';
import 'package:movie_app/screens/video_player.dart';
import 'package:movie_app/style/theme/theme.dart';
import 'package:movie_app/widgets/widgets_for_detail_screen/casts.dart';
import 'package:movie_app/widgets/widgets_for_detail_screen/similar_movies.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/widgets_for_detail_screen/movie_info.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    implements MovieVideosListContract {
  List<Video> _videosList = [];
  String _errorMessage = '';
  MovieVideosListPresenter? _movieVideosListPresenter;
  _DetailScreenState() {
    _movieVideosListPresenter = MovieVideosListPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieVideosListPresenter?.loadMovieVideos(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Builder(
        builder: (context) {
          Size size = MediaQuery.of(context).size;

          return Stack(
            children: [
              _buildVideoWidget(size),
              Positioned(
                right: size.width * 0.05,
                top: size.height * 0.25,
                child: _buildVideoPlayingWidget(_videosList),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildVideoWidget(Size size) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          expandedHeight: size.height * 0.25,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.02,
                right: size.width * 0.1,
              ),
              child: Text(
                widget.movie.title.length > 40
                    ? '${widget.movie.title.substring(0, 37)}...'
                    : widget.movie.title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            background: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/original/${widget.movie.backPoster}'),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.1),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.movie.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      RatingBar(
                        itemSize: 8.0,
                        ratingWidget: RatingWidget(
                          empty: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                          full: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                          half: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                        ),
                        initialRating: widget.movie.rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    'OVERVIEW',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.movie.overview,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MovieInformation(id: widget.movie.id),
                Casts(id: widget.movie.id),
                SimilarMovies(id: widget.movie.id),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayingWidget(List<Video> videosList) {
    return (videosList.isEmpty)
        ? const SizedBox()
        : FloatingActionButton(
            backgroundColor: Colors.orange.shade800,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return VideoPlayerScreen(
                      youtubePlayerController: YoutubePlayerController(
                        flags: const YoutubePlayerFlags(
                          showLiveFullscreenButton: true,
                          autoPlay: true,
                        ),
                        initialVideoId: videosList[0].key,
                      ),
                    );
                  },
                ),
              );
            },
            child: const Icon(
              Icons.play_arrow,
            ),
          );
  }

  @override
  void onLoadMovieVideosCompleteWithSuccess(List<Video> videosList) {
    // TODO: implement onLoadMovieVideosCompleteWithSuccess
    setState(() {
      _errorMessage = '';
      _videosList = videosList;
    });
  }

  @override
  void onLoadMovieVideosWithError(String errorMessage) {
    // TODO: implement onLoadMovieVideosWithError
    setState(() {
      _errorMessage = errorMessage;

      _videosList = [];
    });
  }
}
