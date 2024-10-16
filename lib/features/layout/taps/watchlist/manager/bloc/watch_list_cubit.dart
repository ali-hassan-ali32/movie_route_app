import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/watchlist/manager/bloc/watch_list_states.dart';

import '../../../../../../core/utils/objects.dart';
import '../../../home/manager/cache/cache_helper.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(InitalWatchListState());

  static WatchListCubit get(context) => BlocProvider.of(context);

  List<Movie> moviesWatchList = [];
  List<num> moviesIds = [];

  void refreshState() {
    if (!isClosed) {
      emit(InitalWatchListState());
    }
  }

  bool addMovieToWatchList(Movie movie) {
    if (!isMovieAdded(movie)) {
      moviesWatchList.add(movie);
      moviesIds.add(movie.id!);
      refreshState();
      CacheHelper.saveMovie(movie); // Update method call
      return true;
    }
    return false;
  }

  Future<void> getSavedMovies() async {
    moviesWatchList = await CacheHelper.getMovies(); // Update method call
    moviesIds =
        moviesWatchList.map((movie) => movie.id!).toList(); // Extract IDs
    refreshState();
  }

  bool isMovieAdded(Movie movie) {
    return moviesIds.contains(movie.id);
  }

  void removeMovieFromWatchList(Movie movie) {
    moviesWatchList.remove(movie);
    moviesIds.remove(movie.id);
    refreshState();
    CacheHelper.deleteMovie(movie);
  }
}
