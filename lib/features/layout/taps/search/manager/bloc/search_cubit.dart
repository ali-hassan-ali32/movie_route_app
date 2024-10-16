import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_route_app/features/layout/taps/search/manager/bloc/search_states.dart';

import '../../../../../../core/models/searched_movies/searched_movie_model.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../../data/manager/apis/search_api.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(): super(InitalSearchState());
  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<SearchedMovie> searchList = [];


  void clearSearch() {
    searchQuery = '';
    searchController.clear();
    emit(InitalSearchState());
  }

  Future<void> getSearchList({required String searchQuery}) async {
    emit(GetSearchMoviesLoading());

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      emit(GetSearchMoviesError());
    }

    try {
      SearchedMovieModel movies = await SearchApi.getSearchMovies(searchQuery: searchQuery);
      searchList = movies.results ?? [];

      if (searchList.isEmpty) {
        emit(GetSearchMoviesNotFoundState());
      } else {
        for(var movie in searchList) {
          log(movie.title.toString());
        }
        emit(GetSearchMoviesSuccses());
      }
    } catch (e) {
      failureNotifcation();
      emit(GetSearchMoviesError());
    }
  }

}