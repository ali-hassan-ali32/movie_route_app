import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/cache_helper/cache_helper.dart';
import 'package:toastification/toastification.dart';
import '../../../../../../core/models/genres/movie_genres_model.dart';
import '../../../../../../core/models/movie_details/movie_details_model.dart';
import '../../../../../../core/models/popular_movies/popular_movies_model.dart';
import '../../../../../../core/models/top_rated/top_rated_movies_model.dart';
import '../../../../../../core/models/upcoming_movies/upcoming_movies_model.dart';
import '../../../../../../core/utils/classes.dart';
import '../../../../../../data/manager/movie_genres_api.dart';
import '../../../../../../data/manager/popular_movies_api.dart';
import '../../../../../../data/manager/top_rated_movies_api.dart';
import '../../../../../../data/manager/upcoming_movies_api.dart';
import '../../../../../../main.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(): super(InitalHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);



  int selectedMovieDetailsTap = 0;
  int selectedCarouselSliderMovie = 0;
  bool carouseSliderMovieAutoPlay = true;

  MovieDetailsModel? currentMovie;

  MoviesStack moviesStack = MoviesStack();

  // List<num> moviesWatchListIds = [];
  List<PopularMovie> popularMovies = [];
  List<MoviesGenres> moviesGenres = [];
  List<UpcomingMovie> upcomingMovies = [];
  List<TopRatedMovie> topRatedMovies = [];
  List<Movie> savedMovie=[];
  Movie? movie;

  void getFilms(){
    CacheHelper.getMovies();
    print(savedMovie);
    // print(savedMovie[0].id);
    // emit(InitalHomeState());

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
      // you can also use RichText widget for title and description parameters
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
      primaryColor: customOrange,
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
      // you can also use RichText widget for title and description parameters
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
        failureNotifcation();  // Notify the user of empty data
        emit(GetHomeMoviesDataError());  // Emit error state
      } else {
        emit(GetHomeMoviesDataSuccses());  // Emit success state with data
      }
    } catch (e) {
      failureNotifcation();  // Notify the user of an error
      emit(GetHomeMoviesDataError());  // Emit error state
    }
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

      MoviesGenresModel moviesGenresModel = await MoviesGenresApi.getMoviesGenres();
      moviesGenres = moviesGenresModel.genres ?? [];

      //   Here the list
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

  // Future<void> getHomePageMoviesData() async {
  //   resetData();
  //   emit(GetHomeMoviesDataLoading());
  //
  //   try {
  //     bool isConnected = await InternetConnectionChecker().hasConnection;
  //     if (!isConnected) {
  //       emit(GetHomeMoviesDataError());
  //       return; // Exit if no connection
  //     }
  //
  //     // Fetch only upcoming movies
  //     UpcomingMoviesModel upcomingMoviesModel = await UpcomingMoviesApi.getUpcomingMovies();
  //     upcomingMovies = upcomingMoviesModel.upcomingMoviesList ?? [];
  //
  //     // Check if the list is empty
  //     if (upcomingMovies.isEmpty) {
  //       failureNotifcation();
  //       emit(GetHomeMoviesDataError());
  //     } else {
  //       emit(GetHomeMoviesDataSuccses()); // You can pass upcomingMovies here if needed
  //     }
  //   } catch (e) {
  //     failureNotifcation();
  //     emit(GetHomeMoviesDataError());
  //   }
  // }


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