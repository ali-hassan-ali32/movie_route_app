import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/functions.dart';
import 'package:movie_route_app/features/layout/widgets/custom_bad_internet_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/movie_details_screen.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../manager/bloc/home_cubit.dart';
import '../manager/bloc/home_state.dart';
import '../widgets/carouse_slider_movie_details.dart';
import '../widgets/home_movies_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return RefreshIndicator(
      onRefresh: () => homeCubit.getHomePageMoviesData(),
      backgroundColor: Colors.black,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetHomeMoviesDataLoading) {
            return const CustomLoadingWidget();
          } else if (state is GetHomeMoviesDataSuccses ||
              state is InitalHomeState) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: getColorsList(
                          baseColor: homeCubit.carousSliderMoviesColors[
                              homeCubit.selectedCarouselSliderMovie]!))),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(top: 5.h),
                    sliver: SliverToBoxAdapter(
                      child: CarouselSlider.builder(
                          itemCount: homeCubit.popularMovies.length,
                          itemBuilder: (context, index, realIndex) {
                            return InkWell(
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsPage(
                                          movie: homeCubit.popularMovies[
                                              homeCubit
                                                  .selectedCarouselSliderMovie]),
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: homeCubit.popularMovies[index]
                                              .posterPath !=
                                          null
                                      ? 'https://image.tmdb.org/t/p/w500/${homeCubit.popularMovies[index].posterPath}'
                                      : '',
                                  width: 80.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, reason) =>
                                homeCubit.onCarouselSliderMove(index),
                            height: 49.h,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            enableInfiniteScroll: true,
                          )),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 1.5.h),
                  ),
                  const SliverToBoxAdapter(
                    child: CarouseSliderMovieDetails(),
                  ),
                  SliverToBoxAdapter(
                      child: HomeMoviesList(
                    title: 'Upcoming Movies',
                    movies: homeCubit.upcomingMovies,
                  )),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 0.5.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: HomeMoviesList(
                    title: 'Top Rated Movies',
                    movies: homeCubit.topRatedMovies,
                  ))
                ],
              ),
            );
          } else {
            return CustomBadInternetHandler(
                onTryAgainTap: () => homeCubit.getHomePageMoviesData());
          }
        },
      ),
    );
  }
}
