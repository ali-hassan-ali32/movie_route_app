import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/classes.dart';
import '../screens/home_page_movies_list_screen.dart';
import 'home_movies_list_item.dart';

class HomeMoviesList extends StatelessWidget {
  const HomeMoviesList({
    super.key,
    required this.title,
    required this.movies,
  });

  final String title;
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeMoviesListScreen(title: title, movies: movies),));
            },
            child: Text(
              'View all',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: movies.length >= 10 ? 10 : movies.length,
            itemBuilder: (context, index) {
              return HomeMoviesListItem(movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}
