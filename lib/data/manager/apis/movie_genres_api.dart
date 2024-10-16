import 'package:dio/dio.dart';

import '../../../core/models/genres/movie_genres_model.dart';

class MoviesGenresApi {

  static Future<MoviesGenresModel> getMoviesGenres() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'http://api.themoviedb.org/3/genre/movie/list?api_key=###',
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          },
        ),
      );
      MoviesGenresModel moviesGenres = MoviesGenresModel.fromJson(response.data);
      return moviesGenres;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['status_message'] ??
          'opps there was and error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('opps there was and error, try later');
    }
  }
}
