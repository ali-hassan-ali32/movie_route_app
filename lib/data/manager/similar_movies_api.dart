import 'package:dio/dio.dart';

import '../../core/models/similar_movies/similar_movie_model.dart';


class SimilarMoviesApi {
  
  static Future<SimilarMovieModel> getSimilarMovies(num? movieId) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('https://api.themoviedb.org/3/movie/$movieId/similar',
        options: Options(
          headers: {
            'Authorization' :
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWYyODUwZTBhMTQ2ZGQ4MjM1NTE2YThlYjVhOTNiYiIsIm5iZiI6MTcyNjU4ODE3MC4xMzIyMDksInN1YiI6IjY2ZTlhM2YyYjY2NzQ2ZGQ3OTBhZGY2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AI9tFB5FhAMk0DFmRrpDgwCgFWiwcj5qhiykOTvwctU"
          }
        )
      );

      SimilarMovieModel similarMoviesModel = SimilarMovieModel.fromJson(response.data);
      return similarMoviesModel;
    }on DioException catch(e) {
      String errorMessage = e.response?.data['status_message'] ?? 'Oops Someting Wrong Happen, try later';
      throw Exception(errorMessage);
    }catch(e) {
      throw Exception('opps there was and error, try later');
    }
  }
}