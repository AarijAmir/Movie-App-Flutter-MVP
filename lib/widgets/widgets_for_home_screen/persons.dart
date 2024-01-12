import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/data/models/person.dart';
import 'package:movie_app/modules/persons_presenter.dart';
import 'package:movie_app/style/theme/theme.dart';

import '../elements/error_element.dart';
import '../elements/loading_element.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({super.key});

  @override
  State<PersonsList> createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList>
    implements PersonsListContract {
  late PersonsListPresenter? _personsListPresenter;
  List<Person> _personsList = [];
  bool _isStartLoading = true;
  String _errorMessage = '';
  _PersonsListState() {
    _personsListPresenter = PersonsListPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _personsListPresenter!.loadPersons();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _personsListPresenter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            'TRENDING PERSONS ON THIS WEEK',
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
        _buildPersonsLoadingOrResultWidget(size),
      ],
    );
  }

  Widget _buildPersonsLoadingOrResultWidget(Size size) {
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
                _personsList.isEmpty)
            ? buildErrorWidget(_errorMessage)
            : _buildPersonsWidget(_personsList);
  }

  Widget _buildPersonsWidget(List<Person> personsList) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: personsList.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100.0,
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 19.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                personsList[index].profileImg == null
                    ? Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondColor,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.userAlt,
                          color: Colors.white,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          120,
                        ),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w200${personsList[index].profileImg}'),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  personsList[index].name,
                  maxLines: 2,
                  style: const TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  'Trending for ${personsList[index].known}',
                  style: const TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 7.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void onLoadPersonsCompleteWithSuccess(List<Person> personsList) {
    // TODO: implement onLoadPersonsCompleteWithSuccess
    setState(() {
      _personsList = personsList;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadPersonsWithError(String errorMessage) {
    // TODO: implement onLoadPersonsWithError
    setState(() {
      _errorMessage = errorMessage;
      _isStartLoading = false;
      _personsList = [];
    });
  }
}
