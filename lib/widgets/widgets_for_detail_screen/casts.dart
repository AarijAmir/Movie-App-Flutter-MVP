import 'package:flutter/material.dart';
import 'package:movie_app/data/models/cast.dart';
import 'package:movie_app/modules/casts_presenter.dart';
import 'package:movie_app/style/theme/theme.dart';
import 'package:movie_app/widgets/elements/error_element.dart';
import 'package:movie_app/widgets/elements/loading_element.dart';

class Casts extends StatefulWidget {
  const Casts({super.key, required this.id});
  final int id;

  @override
  State<Casts> createState() => _CastsState();
}

class _CastsState extends State<Casts> implements CastsListContract {
  late CastsListPresenter? _castsListPresenter;
  List<Cast> _castsList = [];
  bool _isStartLoading = true;
  String _errorMessage = '';
  _CastsState() {
    _castsListPresenter = CastsListPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _castsListPresenter?.loadGenres(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print('ID = ${widget.id}');
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            top: 20.0,
          ),
          child: Text(
            'CASTS',
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        (_isStartLoading)
            ? buildLoadingWidget(size)
            : (_isStartLoading == false &&
                    _errorMessage.isNotEmpty &&
                    _castsList.isEmpty)
                ? buildErrorWidget(_errorMessage)
                : _buildCastsWidget(_castsList)
      ],
    );
  }

  Widget _buildCastsWidget(List<Cast> castsList) {
    return Container(
      height: 140.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castsList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0),
            width: 100.0,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          (castsList[index].img != null)
                              ? 'https://image.tmdb.org/t/p/w300/${castsList[index].img}'
                              : 'https://cdn.vectorstock.com/i/preview-1x/37/40/image-photograph-icon-vector-40323740.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    castsList[index].name ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    castsList[index].character ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onLoadCastsCompleteWithSuccess(List<Cast> castList) {
    // TODO: implement onLoadCastsCompleteWithSuccess
    setState(() {
      _castsList = castList;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadCastsWithError(String errorMessage) {
    // TODO: implement onLoadCastsWithError
    setState(() {
      _errorMessage = errorMessage;
      _isStartLoading = false;
      _castsList = [];
    });
  }
}
