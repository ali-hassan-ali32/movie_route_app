import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_states.dart';

import '../../../../../../core/utils/classes.dart';
import '../../../home/manager/cache/cache_helper.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit(): super(InitalWatchListState());

  static WatchListCubit get(context) => BlocProvider.of(context);

  List<Movie> moviesWatchList = [];
  List<Movie> savedMoviesWatchList = [];

  bool addMovieToWatchList(Movie movie) {
    if (!isMovieAdded(movie)) {
      // emit(InitalWatchListState());
      moviesWatchList.add(movie);
      CacheHelper.saveFilms(movie);
      print(CacheHelper.saveFilms(movie));
      print(moviesWatchList.length);
      return true;
    }
    return false;
  }

  Future<void> getSavedMovies() async {
    savedMoviesWatchList = await CacheHelper.getMovies();
    print(savedMoviesWatchList);
    print(savedMoviesWatchList.length);
  }

  bool isMovieAdded(Movie movie) {
    return moviesWatchList.contains(movie);
  }

  void removeMovieFromWatchList(Movie movie) {
    // emit(WatchListRemoveLoadingState());
    moviesWatchList.remove(movie);
    // emit(WatchListRemoveSuccesState());
    // emit(WatchListRemoveState());
  }

}