import 'package:dio/dio.dart';

import '../../../core/models/generes_movies_filter/genres_movies_filter_model.dart';

class FilteredMoviesApi {

  static Future<GenresMoviesFilterModel> getFilteredMovies(num? genreId) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('https://api.themoviedb.org/3/discover/movie?with_genres=$genreId',
          options: Options(
              headers: {
                'Authorization' :
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
              }
          )
      );

      GenresMoviesFilterModel genresMoviesFilterModel = GenresMoviesFilterModel.fromJson(response.data);
      return genresMoviesFilterModel;
    }on DioException catch(e) {
      String errorMessage = e.response?.data['status_message'] ?? 'Oops Someting Wrong Happen, try later';
      throw Exception(errorMessage);
    }catch(e) {
      throw Exception('opps there was and error, try later');
    }
  }
}