import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:toastification/toastification.dart';
import '../../../core/models/movie_casts/movie_casts_model.dart';
import '../../../core/models/movie_details/movie_details_model.dart';
import '../../../core/models/similar_movies/similar_movie_model.dart';
import '../../../data/manager/movie_casts_api.dart';
import '../../../data/manager/movie_details_api.dart';
import '../../../data/manager/similar_movies_api.dart';
import 'movie_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {

  MovieDetailsCubit(): super(InitalMoviesDetailsState());
  static MovieDetailsCubit get(context) => BlocProvider.of(context);


  MovieDetailsModel? currentMovie;
  int selectedMovieDetailsTap = 0;
  // MoviesStack moviesStack = MoviesStack();


  List<Crew> currentMovieCasts = [];
  List<SimilarMovie> currentSimilarMovies = [];


  void movieDetailsFailureNotifcation() {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text(
        'Movie Not Found',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      description: const Text('The Movie Not Found In Severe',style: TextStyle(color: Colors.white),),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.warning,color: Colors.white,),
      primaryColor: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      showProgressBar: false,
      applyBlurEffect: true,
    );
  }

  void onMovieDetailsTapPress(value) {
    selectedMovieDetailsTap = value;
    emit(InitalMoviesDetailsState());
  }

  void onGetOutFromMovieDetailsPage() {
    resetData();
    // moviesStack.pop();
    // currentMovie = moviesStack.peek();
    emit(InitalMoviesDetailsState());
  }

  void resetData() {
    // playCarouseSliderMovieAuto();
    selectedMovieDetailsTap = 0;
    currentMovie = null;
  }

  Future<void> getMovieDetails({required num? movieId}) async {
    resetData();
    emit(GetMovieDetailsDataLoading());

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      emit(GetMovieDetailsDataError());
    }

    try {
      currentMovie = await MovieDetailsApi.getMovieDetails(movieId: movieId);

      MovieCastsModel movieCastsModel = await MovieCastsApi.getMovieCasts(movieId: movieId);
      currentMovieCasts = movieCastsModel.crew ?? [];

      SimilarMovieModel moreLikeMoviesModel = await SimilarMoviesApi.getSimilarMovies(movieId);
      currentSimilarMovies = moreLikeMoviesModel.results ?? [];

      if (currentMovieCasts.isEmpty || currentSimilarMovies.isEmpty) {
        movieDetailsFailureNotifcation();
        emit(GetMovieDetailsDataError());
      } else {
        // moviesStack.push(currentMovie!);
        emit(GetMovieDetailsDataSuccses());
      }
      // emit(MoviesFoundState());
    } catch (e) {
      movieDetailsFailureNotifcation();
      emit(GetMovieDetailsDataError());
    }
  }

}