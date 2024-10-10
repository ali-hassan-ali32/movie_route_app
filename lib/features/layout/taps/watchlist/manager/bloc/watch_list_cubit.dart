
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/cache_helper/cache_helper.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_states.dart';

import '../../../../../../core/utils/classes.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit(): super(InitalWatchListState());
  static WatchListCubit get(context) => BlocProvider.of(context);


  List<Movie> moviesWatchList = [];
  @override
  bool isClosed = false;
  List<Movie> savedMoviesWatchList = [];

  void addMovieToWatchList(Movie movie) {
    Future.delayed(Duration(milliseconds: 500),(){
      emit(AddMovieLoadingState());
      if (!isMovieAdded(movie)) {

        moviesWatchList.add(movie);
        CacheHelper.saveFilms(moviesWatchList);
        emit(AddMovieSuccesState());
        print(moviesWatchList.length);
        print(savedMoviesWatchList.length);
        return true;
      }
      return false;
    });
  }
  @override
  Future<void> close() {
    isClosed = true; // Set the flag to true on close
    return super.close();
  }


  Future<void> getSavedMovies() async {
    Future.delayed(Duration( milliseconds: 500),() async{
      emit(WatchListRemoveLoadingState());
      try {
        savedMoviesWatchList = await CacheHelper.getMovies();
        print(savedMoviesWatchList.length);

        // CacheHelper.saveFilms(savedMoviesWatchList);
        if (!isClosed) {
          emit(WatchListRemoveSuccesState());
        }
      } catch (e) {
        emit(GetWatchListErrorState());
        rethrow;
      }
    });
  }
  void deleteSavedMovie(Movie movie) async {
    await CacheHelper.deleteMovie(movie.title ?? "");

    // Check if the BLoC is closed before emitting a new state
    if (!isClosed) { // Make sure to add an `isClosed` flag to check the status of the BLoC
      // emit(WatchListDeleteState());
    }
  }


  bool isMovieAdded(Movie movie) {
    return moviesWatchList.contains(movie);

  }

  bool isMovieSaved(Movie? movie) {
    return savedMoviesWatchList.contains(movie);
  }

  void removeMovieFromWatchList(Movie? movie) {
    // emit(WatchListRemoveLoadingState());
    moviesWatchList.remove(movie);
    // emit(WatchListDeleteState());

    // emit(WatchListRemoveSuccesState());
    // emit(WatchListRemoveState());
  }void removeMovieFromSavedWatchList(Movie? movie) {
    // emit(WatchListRemoveLoadingState());
    Future.delayed(Duration(milliseconds: 500),()async{
      emit(WatchListDeleteLoadingState());

     // await CacheHelper.deleteMovie(movie?.title??"");

       savedMoviesWatchList.remove(movie);
       print(savedMoviesWatchList.length);
      emit(WatchListDeleteSuccesState());
    });
    // emit(WatchListDeleteState());

    // emit(WatchListRemoveSuccesState());
    // emit(WatchListRemoveState());
  }

}