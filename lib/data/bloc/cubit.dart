// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:movies_app/core/models/generes_movies_filter/genres_movies_filter_model.dart';
// import 'package:movies_app/core/models/genres/movie_genres_model.dart';
// import 'package:movies_app/core/models/movie_details/movie_details_model.dart';
// import 'package:movies_app/core/models/popular_movies/popular_movies_model.dart';
// import 'package:movies_app/core/models/searched_movies/searched_movie_model.dart';
// import 'package:movies_app/core/models/similar_movies/similar_movie_model.dart';
// import 'package:movies_app/core/models/top_rated/top_rated_movies_model.dart';
// import 'package:movies_app/core/models/upcoming_movies/upcoming_movies_model.dart';
// import 'package:movies_app/data/bloc/state.dart';
// import 'package:movies_app/data/manager/movie_casts_api.dart';
// import 'package:movies_app/data/manager/movie_details_api.dart';
// import 'package:movies_app/main.dart';
// import 'package:toastification/toastification.dart';
// import '../../core/models/movie_casts/movie_casts_model.dart';
// import '../manager/similar_movies_api.dart';
//
// class MovieCubit extends Cubit<MovieState> {
//   MovieCubit() : super(InitalMovieState());
//   static MovieCubit get(context) => BlocProvider.of(context);
//
//   // TextEditingController searchController = TextEditingController();
//   // String searchQuery = '';
//
//   int selectedMovieDetailsTap = 0;
//   int selectedCarouselSliderMovie = 0;
//   int selectedTap = 0;
//
//   bool carouseSliderMovieAutoPlay = true;
//
//   MovieDetailsModel? currentMovie;
//   // MovieDetailsModel? prevMovie;
//
//   MoviesStack moviesStack = MoviesStack();
//
//   List<SearchedMovie> searchList = [];
//   List<SimilarMovie> currentSimilarMovies = [];
//   List<num> moviesWatchListIds = [];
//   List<Crew> currentMovieCasts = [];
//   List<PopularMovie> popularMovies = [];
//   List<MoviesGenres> moviesGenres = [];
//   List<UpcomingMovie> upcomingMovies = [];
//   List<TopRatedMovie> topRatedMovies = [];
//   List<FilteredMovie> currentFilteredMovies = [];
//
//                              // Home Page
//
//   // Future<void> getHomePageMoviesData() async {
//   //   resetData();
//   //   emit(GetHomeDataLoading());
//   //   try {
//   //     bool isConnected = await InternetConnectionChecker().hasConnection;
//   //     if (!isConnected) {
//   //       emit(GetHomeDataError());
//   //     }
//   //     PopularMoviesModel popularMoviesModel = await PopularMoviesApi.getPopularMovies();
//   //     popularMovies = popularMoviesModel.popularMoviesList ?? [];
//   //
//   //     MoviesGenresModel moviesGenresModel = await MoviesGenresApi.getMoviesGenres();
//   //     moviesGenres = moviesGenresModel.genres ?? [];
//   //
//   //     UpcomingMoviesModel upcomingMoviesModel = await UpcomingMoviesApi.getUpcomingMovies();
//   //     upcomingMovies = upcomingMoviesModel.upcomingMoviesList ?? [];
//   //
//   //     TopRatedMoviesModel topRatedMoviesModel = await TopRatedMoviesApi.getTopRatedMovies();
//   //     topRatedMovies = topRatedMoviesModel.topRatedMoviesList ?? [];
//   //
//   //     if (popularMovies.isEmpty || moviesGenres.isEmpty || upcomingMovies.isEmpty || upcomingMovies.isEmpty) {
//   //       failureNotifcation();
//   //       emit(GetHomeDataError());
//   //     }
//   //     else {
//   //       emit(GetHomeDataSuccses());
//   //     }
//   //   } catch (e) {
//   //     failureNotifcation();
//   //     emit(GetHomeDataError());
//   //   }
//   // }
//
//   List<String> getMovieGenres({required List<num> genresIds}) {
//     List<String> genres = genresIds.map((id) {
//        final MoviesGenres genre = moviesGenres.firstWhere((element) => element.id == id,
//         orElse: () => MoviesGenres(),
//       );
//       return genre.name as String;
//     }).toList();
//
//     return genres;
//   }
//
//   void onCarouselSliderMove(value) {
//     selectedCarouselSliderMovie = value;
//     emit(SetMoviesState());
//   }
//
//   void onGetOutFromMovieDetailsPage() {
//     resetData();
//     moviesStack.pop();
//     currentMovie = moviesStack.peek();
//     emit(SetMoviesState());
//   }
//
//   void onMovieDetailsTapPress(value) {
//     selectedMovieDetailsTap = value;
//     emit(SetMoviesState());
//   }
//
//   bool addMovieToWatchList(num movieId) {
//     if (!isMovieAdded(movieId)) {
//       moviesWatchListIds.add(movieId);
//       return true;
//     }
//     return false;
//   }
//
//   bool isMovieAdded(num movieId) {
//     return moviesWatchListIds.contains(movieId);
//   }
//
//   void removeMovieFromWatchList(num movieId) {
//     moviesWatchListIds.remove(movieId);
//   }
//
//   // Future<void> getMovieDetails({required num? movieId}) async {
//   //   resetData();
//   //   emit(GetMovieDetailsDataLoading());
//   //
//   //   bool isConnected = await InternetConnectionChecker().hasConnection;
//   //   if (!isConnected) {
//   //     emit(GetMovieDetailsDataError());
//   //   }
//   //
//   //   try {
//   //     currentMovie = await MovieDetailsApi.getMovieDetails(movieId: movieId);
//   //
//   //     MovieCastsModel movieCastsModel = await MovieCastsApi.getMovieCasts(movieId: movieId);
//   //     currentMovieCasts = movieCastsModel.crew ?? [];
//   //
//   //     SimilarMovieModel moreLikeMoviesModel = await SimilarMoviesApi.getSimilarMovies(movieId);
//   //     currentSimilarMovies = moreLikeMoviesModel.results ?? [];
//   //
//   //     if (currentMovieCasts.isEmpty || currentSimilarMovies.isEmpty) {
//   //       movieDetailsFailureNotifcation();
//   //       emit(GetMovieDetailsDataError());
//   //     } else {
//   //       moviesStack.push(currentMovie!);
//   //       emit(GetMovieDetailsDataSuccses());
//   //     }
//   //     // emit(MoviesFoundState());
//   //   } catch (e) {
//   //     movieDetailsFailureNotifcation();
//   //     emit(GetMovieDetailsDataError());
//   //   }
//   // }
//
//   //                             Search Page
//   // void clearSearch() {
//   //   searchQuery = '';
//   //   searchController.clear();
//   //   emit(InitalMovieState());
//   // }
//   //
//   // Future<void> getSearchList({required String searchQuery}) async {
//   //   emit(GetSearchDataLoading());
//   //
//   //   bool isConnected = await InternetConnectionChecker().hasConnection;
//   //   if (!isConnected) {
//   //     emit(GetSearchDataError());
//   //   }
//   //
//   //   try {
//   //     SearchedMovieModel movies = await SearchApi.getSearchMovies(searchQuery: searchQuery);
//   //     searchList = movies.results ?? [];
//   //
//   //     if (searchList.isEmpty) {
//   //       emit(GetSearchNotFoundState());
//   //     } else {
//   //       emit(GetSearchDataSuccses());
//   //     }
//   //   } catch (e) {
//   //     failureNotifcation();
//   //     emit(GetSearchDataError());
//   //   }
//   // }
//
//   //                            For General
//
//   void resetData() {
//     // playCarouseSliderMovieAuto();
//     selectedMovieDetailsTap = 0;
//     currentMovie = null;
//   }
//
//   void onWatchPress() {
//     toastification.show(
//       type: ToastificationType.warning,
//       style: ToastificationStyle.fillColored,
//       autoCloseDuration: const Duration(seconds: 5),
//       title: const Text(
//         'Not Available',
//         style: TextStyle(
//             color: Colors.white
//         ),
//       ),
//       // you can also use RichText widget for title and description parameters
//       description: const Text('This Feacture is Not Available Yet',style: TextStyle(color: Colors.white),),
//       alignment: Alignment.topRight,
//       direction: TextDirection.ltr,
//       animationDuration: const Duration(milliseconds: 300),
//       animationBuilder: (context, animation, alignment, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//       icon: const Icon(Icons.warning,color: Colors.white,),
//       primaryColor: customOrange,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0x07000000),
//           blurRadius: 16,
//           offset: Offset(0, 16),
//           spreadRadius: 0,
//         )
//       ],
//       closeButtonShowType: CloseButtonShowType.onHover,
//       closeOnClick: false,
//       pauseOnHover: true,
//       dragToClose: true,
//       showProgressBar: false,
//       applyBlurEffect: true,
//     );
//   }
//
//   void failureNotifcation() {
//     toastification.show(
//       type: ToastificationType.warning,
//       style: ToastificationStyle.fillColored,
//       autoCloseDuration: const Duration(seconds: 5),
//       title: const Text(
//         'No Connection',
//         style: TextStyle(
//             color: Colors.white
//         ),
//       ),
//       // you can also use RichText widget for title and description parameters
//       description: const Text('Please Check Internet Connection',style: TextStyle(color: Colors.white),),
//       alignment: Alignment.topRight,
//       direction: TextDirection.ltr,
//       animationDuration: const Duration(milliseconds: 300),
//       animationBuilder: (context, animation, alignment, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//       icon: const Icon(Icons.signal_wifi_bad,color: Colors.white,),
//       primaryColor: Colors.red,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0x07000000),
//           blurRadius: 16,
//           offset: Offset(0, 16),
//           spreadRadius: 0,
//         )
//       ],
//       closeButtonShowType: CloseButtonShowType.onHover,
//       closeOnClick: false,
//       pauseOnHover: true,
//       dragToClose: true,
//       showProgressBar: false,
//       applyBlurEffect: true,
//     );
//   }
//
//   void movieDetailsFailureNotifcation() {
//     toastification.show(
//       type: ToastificationType.error,
//       style: ToastificationStyle.fillColored,
//       autoCloseDuration: const Duration(seconds: 5),
//       title: const Text(
//         'Movie Not Found',
//         style: TextStyle(
//             color: Colors.white
//         ),
//       ),
//       description: const Text('The Movie Not Found In Severe',style: TextStyle(color: Colors.white),),
//       alignment: Alignment.topRight,
//       direction: TextDirection.ltr,
//       animationDuration: const Duration(milliseconds: 300),
//       animationBuilder: (context, animation, alignment, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//       icon: const Icon(Icons.warning,color: Colors.white,),
//       primaryColor: Colors.red,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0x07000000),
//           blurRadius: 16,
//           offset: Offset(0, 16),
//           spreadRadius: 0,
//         )
//       ],
//       closeButtonShowType: CloseButtonShowType.onHover,
//       closeOnClick: false,
//       pauseOnHover: true,
//       dragToClose: true,
//       showProgressBar: false,
//       applyBlurEffect: true,
//     );
//   }
//
//   void stopCarouseSliderMovieAuto() {
//     carouseSliderMovieAutoPlay = false;
//     emit(SetMoviesState());
//   }
//
//   void playCarouseSliderMovieAuto() {
//     carouseSliderMovieAutoPlay = true;
//     emit(SetMoviesState());
//   }
//
//   // void onTapPress(value) {
//   //   selectedTap = value;
//   //   if(searchQuery.isNotEmpty) {
//   //     emit(SetMoviesState());
//   //   }else {
//   //   emit(InitalMovieState());
//   //   }
//   // }
//
//   //                          Browser
//   // Future<void> getMoviesGenres() async {
//   //   emit(GetBroswerDataLoading());
//   //   try {
//   //     MoviesGenresModel moviesGenresModel = await MoviesGenresApi.getMoviesGenres();
//   //     moviesGenres = moviesGenresModel.genres ?? [];
//   //     if(moviesGenres.isEmpty) {
//   //       emit(GetBroswerDataError());
//   //     }else{
//   //      emit(GetBroswerDataSuccses());
//   //     }
//   //   } catch (e) {
//   //     emit(GetBroswerDataError());
//   //   }
//   // }
//   //
//   // Future<void> getFilteredMovies({num? genreId}) async {
//   //   emit(GetBroswerDataLoading());
//   //   try {
//   //     GenresMoviesFilterModel genresMoviesFilterModel = await FilteredMoviesApi.getFilteredMovies(genreId);
//   //     currentFilteredMovies = genresMoviesFilterModel.filteredMoviesList ?? [];
//   //
//   //     if(currentFilteredMovies.isEmpty) {
//   //       failureNotifcation();
//   //       emit(GetBroswerDataError());
//   //     }else {
//   //       emit(GetBroswerDataSuccses());
//   //     }
//   //   } catch (e) {
//   //     failureNotifcation();
//   //     emit(GetBroswerDataError());
//   //   }
//   // }
//
// }
// //                            important classes
// abstract class Movie {
//   bool? adult;
//   String? backdropPath;
//   List<num>? genreIds;
//   num? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   num? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   bool? video;
//   num? voteAverage;
//   num? voteCount;
// }
//
// class MoviesStack {
//   List<MovieDetailsModel> movies = [];
//
//   MoviesStack() {
//     movies = [];
//   }
//
//   void push(MovieDetailsModel movie) {
//     movies.add(movie);
//   }
//
//   MovieDetailsModel? pop() {
//     if (movies.isNotEmpty) {
//       return movies.removeLast();
//     }
//     return null;
//   }
//
//   MovieDetailsModel? peek() {
//     if (movies.isNotEmpty) {
//       return movies.last;
//     }
//     return null;
//   }
//
//   bool isEmpty() {
//     return movies.isEmpty;
//   }
//
//   void clear() {
//     while(movies.isNotEmpty) {
//       pop();
//     }
//   }
// }
