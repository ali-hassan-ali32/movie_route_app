import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_states.dart';
import '../../../screens/movie_details_screen.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../manager/bloc/home_cubit.dart';
import '../manager/bloc/home_state.dart';
import '../widgets/carouse_slider_movie_details.dart';
import 'package:sizer/sizer.dart';
import '../widgets/home_movies_list.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is GetHomeMoviesDataLoading) {
          return const CustomLoadingWidget();
        }
        else if (state is GetHomeMoviesDataSuccses || state is InitalHomeState) {
          return RefreshIndicator(
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
                              homeCubit.stopCarouseSliderMovieAuto();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movie: homeCubit.popularMovies[homeCubit.selectedCarouselSliderMovie]),));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: homeCubit.popularMovies[index].posterPath !=
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
                          height: 450,
                          enlargeCenterPage: true,
                          autoPlay: homeCubit.carouseSliderMovieAutoPlay,
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
                SliverToBoxAdapter(child: HomeMoviesList(title: 'Upcoming Movies', movies: homeCubit.upcomingMovies,)),
                SliverToBoxAdapter(
                  child: SizedBox(height: 0.5.h,),
                ),
                SliverToBoxAdapter(child: HomeMoviesList(title: 'Top Rated Movies', movies: homeCubit.topRatedMovies,))
              ],
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