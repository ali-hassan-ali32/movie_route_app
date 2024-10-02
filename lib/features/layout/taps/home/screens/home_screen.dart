import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/constants.dart';
import 'package:movie_route_app/core/utils/functions.dart';
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

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetHomeMoviesDataLoading) {
          return const CustomLoadingWidget();
        }
        else if (state is GetHomeMoviesDataSuccses || state is InitalHomeState) {
          return DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: getColorsList(homeCubit.carousSliderMoviesColors[
                        homeCubit.selectedCarouselSliderMovie]!))),
            child: RefreshIndicator(
              onRefresh: () => homeCubit.getHomePageMoviesData(),
              backgroundColor: Colors.black,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(top: 5.h),
                    sliver: SliverToBoxAdapter(
                      child: CarouselSlider.builder(
                          itemCount: homeCubit.popularMovies.length,
                          itemBuilder: (context, index, realIndex) {
                            return InkWell(
                              onTap: () {
                                kCarouseSliderMovieAutoPlay = false;
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
                                  width: 400,
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
                            autoPlay: kCarouseSliderMovieAutoPlay,
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
            ),
          );
        }
        else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.do_not_disturb_alt_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 128,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Opps someting Wrong Happen!, try later',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}