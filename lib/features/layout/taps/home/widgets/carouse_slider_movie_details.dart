import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/objects.dart';
import 'package:movie_route_app/features/layout/widgets/custom_add_movie_watch_list_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/movie_details_screen.dart';
import '../manager/bloc/home_cubit.dart';
import '../manager/bloc/home_state.dart';

class CarouseSliderMovieDetails extends StatefulWidget {
  const CarouseSliderMovieDetails({
    super.key,
  });

  @override
  State<CarouseSliderMovieDetails> createState() =>
      _CarouseSliderMovieDetailsState();
}

class _CarouseSliderMovieDetailsState extends State<CarouseSliderMovieDetails> {
  List<Color> colors = const [
    Color(0xFFF4A325),
    Color(0xFFF4931E),
    Color(0xFFF37C18),
    Color(0xFFF2690D),
    Color(0xFFF4B338),
    Color(0xFFFFF9E3),
    Color(0xFFFFF1B6),
    Color(0xFFFFE886),
    Color(0xFFFFE05F),
    Color(0xFFFFD63F),
  ];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    List<String?> movieGenres = homeCubit.getMovieGenres(
        genresIds: homeCubit
                .popularMovies[homeCubit.selectedCarouselSliderMovie]
                .genreIds ??
            []);

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) => setState(() {}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.5.h),
        child: Column(
          children: [
            AnimatedTextKit(
              key: ValueKey(homeCubit
                  .popularMovies[homeCubit.selectedCarouselSliderMovie].title),
              animatedTexts: [
                ColorizeAnimatedText(
                  homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]
                          .title ??
                      'No Title',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                  colors: colors,
                ),
              ],
              isRepeatingAnimation: false,
            ),
            SizedBox(
              height: 1.h,
            ),
            AnimatedTextKit(
              key: ValueKey(movieGenres),
              isRepeatingAnimation: false,
              animatedTexts: [
                ColorizeAnimatedText(
                  movieGenres.isNotEmpty ? movieGenres.join(', ') : 'N/A',
                  textStyle: TextStyle(fontSize: 16.sp),
                  colors: colors,
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(
                              movie: homeCubit.popularMovies[
                                  homeCubit.selectedCarouselSliderMovie]),
                        ));
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
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(0, 6.h),
                  ),
                  onPressed: () => homeCubit.onWatchPress(),
                  child: Text(
                    'Watch Now',
                    style: TextStyle(
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                CustomAddWatchListMovieBottom(
                    bottomType: AddMovieBottom.carouseSlider,
                    movie: homeCubit
                        .popularMovies[homeCubit.selectedCarouselSliderMovie]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
