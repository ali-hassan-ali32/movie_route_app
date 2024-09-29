import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/models/generes_movies_filter/genres_movies_filter_model.dart';
import '../../../../../../core/models/genres/movie_genres_model.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../../data/manager/filteried_movies_api.dart';
import '../../../../../../data/manager/movie_genres_api.dart';
import 'browse_states.dart';


class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(): super(InitalBrowseState());
  // static get(context) => BlocProvider.of<BrowseCubit>(context);

  List<MoviesGenres> moviesGenres = [];
  List<FilteredMovie> currentFilteredMovies = [];


  Future<void> getMoviesGenres() async {
    emit(GetBrowseMoviesLoading());
    try {
      MoviesGenresModel moviesGenresModel = await MoviesGenresApi.getMoviesGenres();
      moviesGenres = moviesGenresModel.genres ?? [];
      if(moviesGenres.isEmpty) {
        emit(GetBrowseMoviesError());
      }else{
        emit(GetBrowseMoviesSuccses());
      }
    } catch (e) {
      emit(GetBrowseMoviesError());
    }
  }

  Future<void> getFilteredMovies({num? genreId}) async {
    emit(GetBrowseMoviesLoading());
    try {
      GenresMoviesFilterModel genresMoviesFilterModel = await FilteredMoviesApi.getFilteredMovies(genreId);
      currentFilteredMovies = genresMoviesFilterModel.filteredMoviesList ?? [];

      if(currentFilteredMovies.isEmpty) {
        failureNotifcation();
        emit(GetBrowseMoviesError());
      }else {
        emit(GetBrowseMoviesSuccses());
      }
    } catch (e) {
      failureNotifcation();
      emit(GetBrowseMoviesError());
    }
  }
}