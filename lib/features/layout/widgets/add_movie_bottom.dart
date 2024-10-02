import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/functions.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/classes.dart';
import '../taps/watchlist/manager/bloc/watch_list_cubit.dart';
import '../taps/watchlist/manager/bloc/watch_list_states.dart';

class CustomAddBottom extends StatefulWidget {
  const CustomAddBottom({super.key, required this.movie});

  final Movie? movie;
  @override
  State<CustomAddBottom> createState() => _CustomAddBottomState();
}

class _CustomAddBottomState extends State<CustomAddBottom> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);
    bool isAdded = watchListCubit.isMovieAdded(widget.movie!);

    return BlocListener<WatchListCubit, WatchListState>(
        listener: (context, state) {},
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (isAdded) {
                watchListCubit.removeMovieFromWatchList(widget.movie!);
                removeMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No Title');
              } else {
                watchListCubit.addMovieToWatchList(widget.movie!);
                addMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No title');
              }
            });
          },
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor:
                isAdded ? Theme.of(context).primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: isAdded
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(35.sw, 6.sh),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isAdded ? 'Remove' : 'Add',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: isAdded ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.bookmark,
                size: 20.sp,
                color: isAdded ? Colors.black : Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
