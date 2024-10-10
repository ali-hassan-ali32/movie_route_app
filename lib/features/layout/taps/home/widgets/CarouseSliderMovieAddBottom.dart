import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../watchlist/manager/bloc/watch_list_cubit.dart';
import '../../watchlist/manager/bloc/watch_list_states.dart';
import '../manager/bloc/home_cubit.dart';

class CarouseAddMovieBottom extends StatefulWidget {
  const CarouseAddMovieBottom({super.key});

  @override
  State<CarouseAddMovieBottom> createState() => _CarouseAddMovieBottomState();
}

class _CarouseAddMovieBottomState extends State<CarouseAddMovieBottom> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    WatchListCubit watchListCubit = WatchListCubit.get(context);

    bool isAdded = watchListCubit.isMovieAdded(homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]);

    return BlocListener<WatchListCubit, WatchListState>(
        listener: (context, state) {
          setState(() {});
        },
        child: InkWell(
          onTap: () {
            setState(() {
              if (isAdded) {
                watchListCubit.removeMovieFromWatchList(homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]);
                // log(watchListCubit.moviesWatchList.toString());
              } else {
                watchListCubit.addMovieToWatchList(homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]);
                // log(watchListCubit.moviesWatchList.toString());
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
                  color: isAdded ? Theme.of(context).primaryColor : Colors.white,
                  fontSize: 16.sp
                ),
              ),
            ],
          ),
        )
    );
  }
}
