import 'package:flutter/material.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/style/theme/theme.dart';
import 'package:movie_app/widgets/widgets_for_home_screen/genre_movies.dart';

class GenresList extends StatefulWidget {
  const GenresList({super.key, required this.list});
  final List<Genre> list;

  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  _GenresListState();
  late final TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.list.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 307,
      child: DefaultTabController(
        length: widget.list.length,
        child: Scaffold(
          backgroundColor: mainColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: widget.list.map((e) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: Text(
                      e.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.list
                .map(
                  (e) => GenresMovie(
                    genreId: e.id,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
