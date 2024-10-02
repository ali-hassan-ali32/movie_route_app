import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/constants.dart';
import 'package:movie_route_app/core/utils/functions.dart';
import 'package:movie_route_app/features/layout/taps/search/widgets/movie_search_item.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';
import 'package:sizer/sizer.dart';

import 'manager/bloc/watch_list_states.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    final WatchListCubit watchListCubit = WatchListCubit.get(context);

    return BlocProvider(
      create: (context) => watchListCubit,
      child: BlocConsumer<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (watchListCubit.moviesWatchList.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: watchListCubit.moviesWatchList.length,
                    itemBuilder: (context, index) {
                      final movie = watchListCubit.moviesWatchList[index];
                      return Dismissible(
                        key: ValueKey(movie.id),
                        // Unique key for each movie
                        direction: DismissDirection.endToStart,
                        // Swipe to remove
                        onDismissed: (direction) {
                          setState(() {
                            watchListCubit.removeMovieFromWatchList(
                                movie); // Remove movie when swiped
                            removeMovieToWatchListNotifcation(
                                movieTitle: movie.title ?? 'No Title');
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: MovieItem(
                            movie: movie), // MovieItem remains the same
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 40.sp,
                    color: kPrimalyColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The Watch List is Empty, Add Movies to Watch Later',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
