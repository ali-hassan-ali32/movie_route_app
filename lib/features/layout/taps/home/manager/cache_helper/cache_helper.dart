
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/utils/classes.dart';

class CacheHelper{

  static Future<void> saveFilms(List<Movie>? moviesToSave) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'Films',
      {'SavedFilms'},
      path: appDocumentsDir.path,
    );

    final catsBox = await collection.openBox<List>('SavedFilms');

    // Convert the list of Movie objects to JSON
    if (moviesToSave != null && moviesToSave.isNotEmpty) {
      List jsonMovies = moviesToSave.map((movie) => movie.toJson()).toList();
      await catsBox.put("movies", jsonMovies);
      print("Saved movies: $jsonMovies");
    } else {
      print("No movies to save.");
    }
  }
  static Future<void> deleteMovie(String title) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'Films',
      {'SavedFilms'},
      path: appDocumentsDir.path,
    );

    final catsBox = await collection.openBox<List>('SavedFilms');

    // Retrieve the current list of movies
    var jsonList = await catsBox.get("movies") ?? [];

    // Find the index of the movie you want to delete
    int indexToRemove = jsonList.indexWhere((movieJson) => Movie.fromJson(movieJson).title == title);

    if (indexToRemove != -1) {
      jsonList.removeAt(indexToRemove); // Remove the movie
      await catsBox.put("movies", jsonList); // Save the updated list back to the box
      print("Deleted movie with title: $title");
    } else {
      print("Movie with title: $title not found.");
    }
  }

  static Future<List<Movie>> getMovies() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'Films', // Name of your database
      {'SavedFilms'}, // Names of your boxes
      path: appDocumentsDir.path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    final catsBox = await collection.openBox<List>('SavedFilms');

    // Retrieve the list of JSON objects
    var jsonList = await catsBox.get("movies") ?? [];

    List<Movie> retrievedMovies = jsonList.map((json) => Movie.fromJson(json)).toList();

    return retrievedMovies;
  }
}