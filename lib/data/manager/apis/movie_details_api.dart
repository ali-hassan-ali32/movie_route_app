import 'package:dio/dio.dart';

import '../../../core/models/movie_details/movie_details_model.dart';

class MovieDetailsApi {


  static Future<MovieDetailsModel> getMovieDetails({required num? movieId}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/$movieId',
          options: Options(
              headers: {
                "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
              }
          )
      );
      MovieDetailsModel movie = MovieDetailsModel.fromJson(response.data);
      return movie;
    } on DioException catch (e) {
      String errorMessage = e.response?.data['status_message'] ?? 'Oops Someting Wrong Happen, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Oops Someting Wrong Happen, try later');
    }
  }
}
