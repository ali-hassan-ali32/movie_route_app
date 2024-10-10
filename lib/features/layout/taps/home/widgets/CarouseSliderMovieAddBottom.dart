import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/classes.dart';
import 'package:movie_route_app/core/utils/functions.dart';
import 'package:sizer/sizer.dart';

import '../../watchlist/manager/bloc/watch_list_cubit.dart';
import '../../watchlist/manager/bloc/watch_list_states.dart';

class CarouseAddMovieBottom extends StatefulWidget {
  const CarouseAddMovieBottom({super.key, required this.movie});

  final Movie? movie;
  @override
  State<CarouseAddMovieBottom> createState() => _CarouseAddMovieBottomState();
}

class _CarouseAddMovieBottomState extends State<CarouseAddMovieBottom> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);
    bool isAdded = watchListCubit.isMovieAdded(widget.movie!);

    return BlocListener<WatchListCubit, WatchListState>(
        listener: (context, state) {
          setState(() {});
        },
        child: InkWell(
          onTap: () {
            setState(() {
              if (isAdded) {
                watchListCubit.removeMovieFromWatchList(widget.movie!);
                removeMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No Title');
              } else {
                watchListCubit.addMovieToWatchList(widget.movie!);
                addMovieToWatchListNotifcation(
                    movieTitle: widget.movie?.title ?? 'No Title');
              }
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bookmark,
                color: isAdded ? Theme.of(context).primaryColor : Colors.white,
                size: 24.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Add',
                style: TextStyle(
                    color: watchListCubit.isMovieAdded(widget.movie!)
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    fontSize: 16.sp
                ),
              ),
            ],
          ),
        )
    );
  }
}
