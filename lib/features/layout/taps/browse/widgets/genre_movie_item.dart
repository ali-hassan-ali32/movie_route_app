import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/models/genres/movie_genres_model.dart';
import '../../../../../core/utils/constants.dart';
import '../screens/genre_movies_list_screen.dart';

class GenreMovieItem extends StatelessWidget {
  const GenreMovieItem({
    super.key,
    required this.genres,
  });

  final List<MoviesGenres> genres;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(0.8.w),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 29.w / 29.w,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    kPrimalyColor,
                    kPrimalyColor.shade900,
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenreMoviesListScreen(
                                title: genres[index].name ?? 'Unknown',
                                genreId: genres[index].id),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff121312),
                        fixedSize: Size(28.w, 28.w)),
                    child: Text(
                      genres[index].name ?? 'Unknown',
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
