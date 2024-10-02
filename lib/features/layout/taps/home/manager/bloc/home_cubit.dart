import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:toastification/toastification.dart';

import '../../../../../../core/models/genres/movie_genres_model.dart';
import '../../../../../../core/models/movie_details/movie_details_model.dart';
import '../../../../../../core/models/popular_movies/popular_movies_model.dart';
import '../../../../../../core/models/top_rated/top_rated_movies_model.dart';
import '../../../../../../core/models/upcoming_movies/upcoming_movies_model.dart';
import '../../../../../../core/utils/classes.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/manager/movie_genres_api.dart';
import '../../../../../../data/manager/popular_movies_api.dart';
import '../../../../../../data/manager/top_rated_movies_api.dart';
import '../../../../../../data/manager/upcoming_movies_api.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(): super(InitalHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedTap = 0;
  int selectedMovieDetailsTap = 0;
  int selectedCarouselSliderMovie = 0;

  bool carouseSliderMovieAutoPlay = true;

  MovieDetailsModel? currentMovie;
  MoviesStack moviesStack = MoviesStack();

  List<Color?> carousSliderMoviesColors = [];
  List<PopularMovie> popularMovies = [];
  List<MoviesGenres> moviesGenres = [];
  List<UpcomingMovie> upcomingMovies = [];
  List<TopRatedMovie> topRatedMovies = [];

  Future<List<Color?>> extractColorsFromImages(
      {required List<String> imageUrls}) async {
    List<Color?> colors = [];

    for (String url in imageUrls) {
      try {
        // Generate the palette from the image URL
        final PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(
          NetworkImage(url),
        );
        // Add the dominant color to the list
        colors.add(paletteGenerator.dominantColor?.color);
      } catch (e) {
        // Handle any errors (e.g., network issues, invalid URLs)
        colors.add(null); // Add null if there's an error
      }
    }

    return colors;
  }

  void resetData() {
    playCarouseSliderMovieAuto();
    selectedMovieDetailsTap = 0;
    currentMovie = null;
  }

  void playCarouseSliderMovieAuto() {
    carouseSliderMovieAutoPlay = true;
    emit(InitalHomeState());
  }

  void onWatchPress() {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text(
        'Not Available',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      description: const Text('This Feacture is Not Available Yet',style: TextStyle(color: Colors.white),),
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
      primaryColor: kPrimalyColor,
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

  void failureNotifcation() {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text(
        'No Connection',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      description: const Text('Please Check Internet Connection',style: TextStyle(color: Colors.white),),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.signal_wifi_bad,color: Colors.white,),
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

  void onTapPress(value) {
    selectedTap = value;
    if (value == 0) {
      kCarouseSliderMovieAutoPlay = true;
    } else {
      kCarouseSliderMovieAutoPlay = false;
    }
    emit(InitalHomeState());
  }

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

  void stopCarouseSliderMovieAuto() {
    carouseSliderMovieAutoPlay = false;
    emit(InitalHomeState());
  }

  Future<void> getUpcomingMoviesData() async {
    resetData();  // Reset any previous data
    emit(GetHomeMoviesDataLoading());  // Emit loading state

    try {
      // Check for internet connection
      bool isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected) {
        emit(GetHomeMoviesDataError());  // Emit error state if no connection
        return;  // Exit if no connection
      }

      // Fetch upcoming movies
      UpcomingMoviesModel upcomingMoviesModel = await UpcomingMoviesApi.getUpcomingMovies();
      upcomingMovies = upcomingMoviesModel.upcomingMoviesList ?? [];

      // Check if the list is empty
      if (upcomingMovies.isEmpty) {
        failureNotifcation();
        emit(GetHomeMoviesDataError());  // Emit error state
      } else {
        emit(GetHomeMoviesDataSuccses());  // Emit success state with data
      }
    } catch (e) {
      failureNotifcation();  // Notify the user of an error
      emit(GetHomeMoviesDataError());  // Emit error state
    }
  }

  List<String> getPosterPath({required List<Movie> movies}) {
    List<String> fullPosterPath = [];

    for (var movie in movies) {
      fullPosterPath.add('https://image.tmdb.org/t/p/w500/${movie.posterPath}');
    }
    return fullPosterPath;
  }

  Future<void> getHomePageMoviesData() async {
    resetData();
    emit(GetHomeMoviesDataLoading());
    try {
      bool isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected) {
        emit(GetHomeMoviesDataError());
      }
      PopularMoviesModel popularMoviesModel = await PopularMoviesApi.getPopularMovies();
      popularMovies = popularMoviesModel.popularMoviesList ?? [];
      carousSliderMoviesColors = await extractColorsFromImages(
          imageUrls: getPosterPath(movies: popularMovies));

      MoviesGenresModel moviesGenresModel = await MoviesGenresApi.getMoviesGenres();
      moviesGenres = moviesGenresModel.genres ?? [];

      UpcomingMoviesModel upcomingMoviesModel = await UpcomingMoviesApi.getUpcomingMovies();
      upcomingMovies = upcomingMoviesModel.upcomingMoviesList ?? [];

      TopRatedMoviesModel topRatedMoviesModel = await TopRatedMoviesApi.getTopRatedMovies();
      topRatedMovies = topRatedMoviesModel.topRatedMoviesList ?? [];

      if (popularMovies.isEmpty || moviesGenres.isEmpty || upcomingMovies.isEmpty || upcomingMovies.isEmpty) {
        failureNotifcation();
        emit(GetHomeMoviesDataError());
      }
      else {
        emit(GetHomeMoviesDataSuccses());
      }
    } catch (e) {
      failureNotifcation();
      emit(GetHomeMoviesDataError());
    }
  }

  List<String> getMovieGenres({required List<num> genresIds}) {
    List<String> genres = genresIds.map((id) {
      final MoviesGenres genre = moviesGenres.firstWhere((element) => element.id == id,
        orElse: () => MoviesGenres(),
      );
      return genre.name as String;
    }).toList();

    return genres;
  }

  void onCarouselSliderMove(value) {
    selectedCarouselSliderMovie = value;
    emit(InitalHomeState());
  }

  void onGetOutFromMovieDetailsPage() {
    resetData();
    moviesStack.pop();
    currentMovie = moviesStack.peek();
    emit(InitalHomeState());
  }

  void onMovieDetailsTapPress(value) {
    selectedMovieDetailsTap = value;
    emit(InitalHomeState());
  }
}