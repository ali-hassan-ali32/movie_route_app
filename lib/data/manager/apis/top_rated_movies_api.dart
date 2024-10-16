import 'package:dio/dio.dart';

import '../../../core/models/top_rated/top_rated_movies_model.dart';

class TopRatedMoviesApi {

  static Future<TopRatedMoviesModel> getTopRatedMovies() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/top_rated',
        options: Options(
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          },
        ),
      );
      TopRatedMoviesModel topRatedMoviesModel = TopRatedMoviesModel.fromJson(response.data);
      return topRatedMoviesModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['status_message'] ?? 'opps there was and error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('opps there was and error, try later');
    }
  }
}
