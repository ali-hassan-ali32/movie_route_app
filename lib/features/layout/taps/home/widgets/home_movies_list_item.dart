import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/classes.dart';
import '../../../screens/movie_details_screen.dart';

class HomeMoviesListItem extends StatelessWidget {
  const HomeMoviesListItem({super.key, required this.movie});

  final Movie? movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .5.h),
      width: 30.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movie: movie),));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: 21.h,
                    width: 30.w,
                    imageUrl: movie?.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500/${movie!.posterPath}'
                        : '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          'image not found',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 30.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.3),
                          // Colors.black.withOpacity(0.6),
                          Colors.transparent,
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
          SizedBox(height: 1.h,),
          Text(
            movie?.title ?? 'No Title',
            maxLines: 1,
            style: TextStyle(
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
              fontSize: 15.sp,
            ),
          )
        ],
      ),
    );
  }
}
