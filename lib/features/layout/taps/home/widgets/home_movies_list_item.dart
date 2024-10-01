import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/cache_helper/cache_helper.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/utils/classes.dart';
import '../../../screens/movie_details_screen.dart';

class HomeMoviesListItem extends StatefulWidget {
  const HomeMoviesListItem({super.key, required this.movie});

  final Movie? movie;

  @override
  State<HomeMoviesListItem> createState() => _HomeMoviesListItemState();
}

class _HomeMoviesListItemState extends State<HomeMoviesListItem> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);
    bool isAdded = watchListCubit.isMovieAdded(widget.movie!);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: .5.h),
      width: 30.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(movie: widget.movie),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: 21.h,
                    width: 30.w,
                    imageUrl: widget.movie?.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500/${widget.movie!.posterPath}'
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
                  GestureDetector(
                      onTap: () {
                        if (isAdded) {
                          watchListCubit
                              .removeMovieFromWatchList(widget.movie!);
                          toastification.show(
                            context: context,
                            // optional if you use ToastificationWrapper
                            title: Text('Film has been removed successfuly'),
                            backgroundColor: Colors.orange,
                            type: ToastificationType.success,
                            // style:ToastificationStyle.fillColored,
                            // animationDuration: Duration(seconds: 2),
                            autoCloseDuration: const Duration(seconds: 2),
                          );
                        } else {
                          watchListCubit.addMovieToWatchList(widget.movie!);
                          toastification.show(
                            context: context,
                            // optional if you use ToastificationWrapper
                            title: Text('Film has been added successfuly'),
                            backgroundColor: Colors.orange,
                            type: ToastificationType.success,
                            // style:ToastificationStyle.fillColored,
                            // animationDuration: Duration(seconds: 2),
                            autoCloseDuration: const Duration(seconds: 2),
                          );
                        }
                        setState(() {

                        });
                      },
                      child: Image.asset(
                        "assets/icons/bookmark.png",
                        color: isAdded ? Colors.orange : Colors.white,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            widget.movie?.title ?? 'No Title',
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
