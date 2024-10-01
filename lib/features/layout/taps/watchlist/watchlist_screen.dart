import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_cubit.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_state.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/cache_helper/cache_helper.dart';
import 'package:movie_route_app/features/layout/taps/search/widgets/movie_search_item.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';

import 'manager/bloc/watch_list_states.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = WatchListCubit.get(context);

    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<WatchListCubit, WatchListState>(

        builder: (context, state) {


          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.moviesWatchList.length,
                  itemBuilder: (context, index) {
                    return MovieItem(movie: cubit.moviesWatchList[index]);
                  },
                ),
              )
            ],
          );
        },
        listener: (context, state) {
          // if(state is WatchListRemoveLoadingState){
          //   showDialog(context: context, builder:  (context) {
          //     return AlertDialog(
          //       title: Center(child: CircularProgressIndicator(),),
          //     );
          //   },);
          // }
          // if(state is WatchListRemoveSuccesState){
          //   Navigator.pop(context);
          // }
        },
      ),
    );
  }
}
