import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/classes.dart';
import '../bloc/movie_cubit.dart';
import '../bloc/movie_details_states.dart';
import '../widgets/custom_loading_widget.dart';
import '../widgets/movie_details.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie? movie;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<MovieDetailsCubit>(context).getMovieDetails(movieId: widget.movie?.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailsCubit movieDetailsCubit = MovieDetailsCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121312),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is GetMovieDetailsDataLoading) {
              return const CustomLoadingWidget();
            }
            // else if (state is GetMovieDetailsDataSuccses || state is SetMoviesState || state is GetMovieDetailsDataError) {
            //   return MovieDetails(movie: widget.movie,cubit: widget.cubit,);
            // }
            else {
              return MovieDetails(
                movie: widget.movie,
                movieDetailsCubit: movieDetailsCubit,
              );

              // return const Center(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Icon(Icons.do_not_disturb_alt_rounded,color: customOrange,size: 128,),
              //       SizedBox(height: 10,),
              //       Text(
              //         'Opps someting Wrong Happen!, try later',
              //         style: TextStyle(color: Colors.grey,fontSize: 18),
              //       ),
              //     ],
              //   ),
              // );
            }
          },
        ),
      ),
    );
  }
}

// class MovieDetails extends StatelessWidget {
//   const MovieDetails({
//     super.key,
//     required this.movieDetailsCubit,
//     required this.movie,
//   });
//
//   final Movie? movie;
//   final MovieDetailsCubit movieDetailsCubit;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             CachedNetworkImage(
//                 imageUrl: movieDetailsCubit.currentMovie?.backdropPath != null
//                     ? 'https://image.tmdb.org/t/p/w500/${movieDetailsCubit.currentMovie?.backdropPath}'
//                     : '',
//                 height: 46.2.sh,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorWidget: (context, url, error) =>
//                     const Icon(Icons.error, size: 128)),
//             Container(
//               width: double.infinity,
//               height: 46.2.sh,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 movieDetailsCubit.onGetOutFromMovieDetailsPage();
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: customOrange,
//                 size: 22.sp,
//               ),
//             ),
//             Positioned(
//               bottom: 2.sh,
//               left: 4.sw,
//               right: 4.sw,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: CachedNetworkImage(
//                         imageUrl: movieDetailsCubit.currentMovie?.posterPath != null
//                             ? 'https://image.tmdb.org/t/p/w500/${movieDetailsCubit.currentMovie?.posterPath}'
//                             : '',
//                         height: 21.sh,
//                         width: 30.sw,
//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) => const Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.error,
//                                   color: Colors.grey,
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'image not found',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             )),
//                   ),
//                   SizedBox(width: 4.sw),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 2.0.sh),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             movieDetailsCubit.currentMovie?.title ?? 'Unknown Title',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: customOrange,
//                                 size: 18.sp,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 '${movieDetailsCubit.currentMovie?.voteAverage ?? 'N/A'} / 10',
//                                 style: TextStyle(
//                                   color: customOrange,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               Text(
//                                 '(${movieDetailsCubit.currentMovie?.voteCount ?? 0} voted)',
//                                 style: TextStyle(
//                                     fontSize: 16.sp, color: Colors.grey),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             '${movieDetailsCubit.currentMovie?.releaseDate?.year ?? 'N/A'}',
//                             style:
//                                 TextStyle(fontSize: 18.sp, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(
//               onPressed: () => onWatchPress(),
//               style: ElevatedButton.styleFrom(
//                 splashFactory: NoSplash.splashFactory,
//                 backgroundColor: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(color: Colors.grey, width: 2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 minimumSize: Size(35.sw, 6.sh),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Watch',
//                     style: TextStyle(fontSize: 18.sp, color: Colors.white),
//                   ),
//                   const SizedBox(width: 10),
//                   Icon(
//                     Icons.play_arrow_sharp,
//                     color: Colors.white,
//                     size: 20.sp,
//                   ),
//                 ],
//               ),
//             ),
//             CustomAddBottom(movie: movie),
//           ],
//         ),
//         MovieDetailsTabBar(movieDetailsCubit: movieDetailsCubit),
//         Expanded(
//           child: BlocBuilder<MovieDetailsCubit, MovieDetailsCubit>(
//             builder: (context, state) {
//               List<String?> genres =
//                   movieDetailsCubit.currentMovie?.genres?.map((e) => e.name).toList() ?? [];
//               List<String?> casts =
//                   movieDetailsCubit.currentMovieCasts.map((e) => e.name).toList();
//
//               return CustomScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 slivers: [
//                   if (movieDetailsCubit.selectedMovieDetailsTap == 0) ...[
//                     OverviewDetails(movieDetailsCubit: movieDetailsCubit, genres: genres, casts: casts),
//                   ],
//                   if (movieDetailsCubit.selectedMovieDetailsTap == 1) ...[
//                     Visibility(
//                       visible: movieDetailsCubit.currentMovieCasts.isNotEmpty,
//                       replacement: const SliverToBoxAdapter(
//                         child: Text(
//                           'There is No Casts',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       child: SliverPadding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.w),
//                         sliver: SliverGrid(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 4.w,
//                             mainAxisSpacing: 4.w,
//                           ),
//                           delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                               return Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: Stack(
//                                       children: [
//                                         CachedNetworkImage(
//                                           height: 9.h,
//                                           width: 9.h,
//                                           imageUrl: movieDetailsCubit
//                                                       .currentMovieCasts[index]
//                                                       .profilePath !=
//                                                   null
//                                               ? 'https://image.tmdb.org/t/p/w500${movieDetailsCubit.currentMovieCasts[index].profilePath}'
//                                               : '',
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.image),
//                                         ),
//                                         Container(
//                                           width: 9.h,
//                                           height: 9.h,
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Colors.black.withOpacity(0.6),
//                                                 Colors.transparent,
//                                               ],
//                                               begin: Alignment.bottomCenter,
//                                               end: Alignment.topCenter,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(
//                                     movieDetailsCubit.currentMovieCasts[index].name ??
//                                         "Unknown Name",
//                                     style: TextStyle(
//                                       overflow: TextOverflow.ellipsis,
//                                       color: Colors.white,
//                                       fontSize: 15.sp,
//                                     ),
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               );
//                             },
//                             childCount: movieDetailsCubit.currentMovieCasts.length,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                   if (movieDetailsCubit.selectedMovieDetailsTap == 2) ...[
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                           return MovieItem(
//                               movie: movieDetailsCubit.currentSimilarMovies[index]);
//                         },
//                         childCount: movieDetailsCubit.currentSimilarMovies.length,
//                       ),
//                     ),
//                   ],
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
