import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/search/widgets/movie_search_item.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';

import 'manager/bloc/watch_list_states.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => WatchListCubit()..getSavedMovies(),
      child: BlocConsumer<WatchListCubit, WatchListState>(
        listener: (context, state) {
          if (state is WatchListRemoveLoadingState|| state is WatchListDeleteLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          if (state is WatchListRemoveSuccesState|| state is WatchListDeleteSuccesState) {
            Navigator.pop(context);
          }

        },
        builder: (context, state) {
          var cubit = WatchListCubit.get(context);
          if (state is GetWatchListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.savedMoviesWatchList.length,
                  itemBuilder: (context, index) {
                    return MovieItem(movie: cubit.savedMoviesWatchList[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
