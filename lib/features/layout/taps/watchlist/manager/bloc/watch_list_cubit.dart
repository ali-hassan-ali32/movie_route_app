import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_states.dart';

import '../../../../../../core/utils/classes.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit(): super(InitalWatchListState());
  static WatchListCubit get(context) => BlocProvider.of(context);


  List<Movie> moviesWatchList = [];

  bool addMovieToWatchList(Movie movie) {
    if (!isMovieAdded(movie)) {
      emit(InitalWatchListState());
      moviesWatchList.add(movie);
      return true;
    }
    return false;
  }

  bool isMovieAdded(Movie movie) {
    return moviesWatchList.contains(movie);
  }

  void removeMovieFromWatchList(Movie movie) {
    moviesWatchList.remove(movie);
    emit(InitalWatchListState());
  }

}