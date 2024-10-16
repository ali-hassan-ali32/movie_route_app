import 'package:dio/dio.dart';

import '../../../core/models/searched_movies/searched_movie_model.dart';

class SearchApi {


  static Future<SearchedMovieModel> getSearchMovies({required String searchQuery}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/search/movie?query=$searchQuery',
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          },
        ),
      );
      SearchedMovieModel searchedFilmesModel = SearchedMovieModel.fromJson(response.data);
      return searchedFilmesModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'opps there was and error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('opps there was and error, try later');
    }
  }
}
