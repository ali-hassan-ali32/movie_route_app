import 'package:dio/dio.dart';

import '../../../core/models/popular_movies/popular_movies_model.dart';

class PopularMoviesApi {

  static Future<PopularMoviesModel> getPopularMovies() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        options: Options(
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          },
        ),
      );
      PopularMoviesModel popularMoviesModel = PopularMoviesModel.fromJson(response.data);
      return popularMoviesModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['status_message'] ?? 'opps there was and error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('opps there was and error, try later');
    }
  }
}
