import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/functions.dart';

import '../../../../../core/utils/classes.dart';
import '../../../../../core/utils/constants.dart';
import '../../watchlist/manager/bloc/watch_list_cubit.dart';
import '../../watchlist/manager/bloc/watch_list_states.dart';

class HomeMovieAddBottom extends StatefulWidget {
  const HomeMovieAddBottom({super.key, required this.movie});

  final Movie? movie;

  @override
  State<HomeMovieAddBottom> createState() => _CarouseAddMovieBottomState();
}

class _CarouseAddMovieBottomState extends State<HomeMovieAddBottom> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);

    bool isAdded = watchListCubit.isMovieAdded(widget.movie!);

    return BlocListener<WatchListCubit, WatchListState>(
      listener: (context, state) {},
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
          child: ImageIcon(
            const AssetImage(
              'assets/icons/bookmark.png',
            ),
            size: 32,
            color: isAdded ? kPrimalyColor : Colors.grey.withOpacity(0.6),
          )),
    );
  }
}
