import 'package:dio/dio.dart';

import '../../../core/models/upcoming_movies/upcoming_movies_model.dart';

class UpcomingMoviesApi {
  static Future<UpcomingMoviesModel> getUpcomingMovies({int page = 1}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming',
        queryParameters: {'page': page},
        options: Options(
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          },
        ),
      );
      UpcomingMoviesModel upcomingMoviesModel = UpcomingMoviesModel.fromJson(response.data);
      return upcomingMoviesModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['status_message'] ?? 'Oops, there was an error. Try later.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Oops, there was an error. Try later.');
    }
  }
}
