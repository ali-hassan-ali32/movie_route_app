import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_route_app/features/layout/widgets/custom_add_movie_watch_list_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/objects.dart';
import '../../../screens/movie_details_screen.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({super.key, required this.movie});

  final Movie? movie;


  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsPage(movie: widget.movie),
              ));
        },
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: 29.sw,
                    height: 23.2.sh,
                    fit: BoxFit.cover,
                    imageUrl: widget.movie?.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500/${widget.movie!.posterPath}'
                        : '',
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
                    width: 29.sw,
                    height: 23.2.sh,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                      left: -5,
                      child: CustomAddWatchListMovieBottom(
                          bottomType: AddMovieBottom.movieItem,
                          movie: widget.movie)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie?.title ?? 'Unknown Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie?.releaseDate ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18.sp),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.movie?.voteAverage ?? 'N/A'} / 10',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.movie?.overview ?? 'Overview Not Found',
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
