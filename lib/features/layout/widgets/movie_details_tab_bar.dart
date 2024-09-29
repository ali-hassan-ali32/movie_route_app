import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../bloc/movie_cubit.dart';

class MovieDetailsTabBar extends StatefulWidget {
  final MovieDetailsCubit movieDetailsCubit;

  const MovieDetailsTabBar({required this.movieDetailsCubit, Key? key}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MovieDetailsTabBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.8.h),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {
                widget.movieDetailsCubit.onMovieDetailsTapPress(value);
                setState(() {});
              },
              labelPadding: EdgeInsets.symmetric(horizontal: 5.sw),
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    'Overview',
                    style: TextStyle(
                      color: widget.movieDetailsCubit.selectedMovieDetailsTap == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Casts',
                    style: TextStyle(
                      color: widget.movieDetailsCubit.selectedMovieDetailsTap == 1
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'More Like',
                    style: TextStyle(
                      color: widget.movieDetailsCubit.selectedMovieDetailsTap == 2
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
