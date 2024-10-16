import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_route_app/core/utils/functions.dart';
import 'package:movie_route_app/core/utils/objects.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/constants.dart';
import '../taps/watchlist/manager/bloc/watch_list_cubit.dart';
import '../taps/watchlist/manager/bloc/watch_list_states.dart';

class CustomAddWatchListMovieBottom extends StatefulWidget {
  const CustomAddWatchListMovieBottom(
      {super.key, required this.bottomType, required this.movie});

  final AddMovieBottom bottomType;
  final Movie? movie;

  @override
  State<CustomAddWatchListMovieBottom> createState() =>
      _CustomAddWatchListMovieBottomState();
}

class _CustomAddWatchListMovieBottomState
    extends State<CustomAddWatchListMovieBottom> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);
    return BlocConsumer<WatchListCubit, WatchListState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isAdded = WatchListCubit.get(context).isMovieAdded(widget.movie!);

        return InkWell(
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          onTap: () {
            setState(() {
              if (isAdded) {
                watchListCubit.removeMovieFromWatchList(widget.movie!);
                widget.movie?.isAdded = false;
                removeMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No Title');
              } else {
                watchListCubit.addMovieToWatchList(widget.movie!);
                widget.movie?.isAdded = true;
                addMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No Title');
              }
            });
          },
          child: widget.bottomType == AddMovieBottom.carouseSlider
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.bookmark,
                      color: isAdded
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      size: 24.sp,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Add',
                      style: TextStyle(
                          color: isAdded
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          fontSize: 16.sp),
                    ),
                  ],
                )
              : widget.bottomType == AddMovieBottom.movieDetails
                  ? Container(
                      decoration: BoxDecoration(
                        color: isAdded
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          width: 2,
                          color: isAdded
                              ? Theme.of(context).primaryColor
                              : Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isAdded ? 'Remove' : 'Add',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.bookmark,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  : ImageIcon(
                      const AssetImage(
                        'assets/icons/bookmark.png',
                      ),
                      size: 24.sp,
                      color: isAdded
                          ? kPrimalyColor.withOpacity(0.8)
                          : Colors.grey.withOpacity(0.6),
                    ),
        );
      },
    );
  }
}
