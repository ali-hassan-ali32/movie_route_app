import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/models/movie_casts/movie_casts_model.dart';
import '../../../core/models/movie_details/movie_details_model.dart';
import '../../../core/models/similar_movies/similar_movie_model.dart';
import '../../../core/utils/objects.dart';
import '../../../data/manager/apis/movie_casts_api.dart';
import '../../../data/manager/apis/movie_details_api.dart';
import '../../../data/manager/apis/similar_movies_api.dart';
import 'movie_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {

  MovieDetailsCubit(): super(InitalMoviesDetailsState());
  static MovieDetailsCubit get(context) => BlocProvider.of(context);


  MovieDetailsModel? currentMovie;
  int selectedMovieDetailsTap = 0;
  MoviesStack moviesStack = MoviesStack();

  List<Crew> currentMovieCasts = [];
  List<SimilarMovie> currentSimilarMovies = [];

  void onMovieDetailsTapPress(value) {
    selectedMovieDetailsTap = value;
    emit(InitalMoviesDetailsState());
  }

  void onGetOutFromMovieDetailsPage() {
    resetData();
    moviesStack.pop();
    currentMovie = moviesStack.peek();
    emit(InitalMoviesDetailsState());
  }

  void resetData() {
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
        emit(GetMovieDetailsDataError());
      } else {
        moviesStack.push(currentMovie!);
        emit(GetMovieDetailsDataSuccses());
      }
    } catch (e) {
      emit(GetMovieDetailsDataError());
    }
  }

}