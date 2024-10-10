import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/classes.dart';
import '../widgets/home_movies_list_item.dart';

class HomeMoviesListScreen extends StatefulWidget {
  const HomeMoviesListScreen({super.key, required this.title, required this.movies});

  final String title;
  final List<Movie> movies;

  @override
  _HomeMoviesListScreenState createState() => _HomeMoviesListScreenState();
}

class _HomeMoviesListScreenState extends State<HomeMoviesListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).primaryColor)),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 18.w / 120,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return HomeMoviesListItem(
            movie: widget.movies[index],
          );
        },
      ),
    );
  }
}
