import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screens/movie_details_screen.dart';
import '../manager/bloc/home_cubit.dart';
import '../manager/bloc/home_state.dart';
import 'CarouseSliderMovieAddBottom.dart';
import 'package:sizer/sizer.dart';

class CarouseSliderMovieDetails extends StatefulWidget {
  const CarouseSliderMovieDetails({
    super.key,
  });

  @override
  State<CarouseSliderMovieDetails> createState() =>
      _CarouseSliderMovieDetailsState();
}

class _CarouseSliderMovieDetailsState extends State<CarouseSliderMovieDetails> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    List<String?> movieGenres = homeCubit.getMovieGenres(
        genresIds: homeCubit
            .popularMovies[homeCubit.selectedCarouselSliderMovie]
            .genreIds ?? []
    );



    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) => setState(() {}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.5.h),
        child: Column(
          children: [
            Text(
              homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]
                  .title ??
                  'No Title',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              movieGenres.isNotEmpty ? movieGenres.join(', ') : 'N/A',
              maxLines: 1,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey,
                  fontSize: 16.sp
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    homeCubit.stopCarouseSliderMovieAuto();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movie: homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]),));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(0,6.h),
                  ),
                  onPressed: ()=> homeCubit.onWatchPress(),
                  child: Text(
                    'Watch Now',
                    style: TextStyle(
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                const CarouseAddMovieBottom(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
