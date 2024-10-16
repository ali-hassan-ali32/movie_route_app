import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/utils/objects.dart';

class CacheHelper {
  static const kMoviesKey = 'SavedFilms';

  static Future<void> deleteMovie(Movie movie) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kMoviesKey, path: appDocumentsDir.path);

    await box.delete(movie.id);
  }

  // Save a movie to the local storage
  static Future<void> saveMovie(Movie movie) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kMoviesKey, path: appDocumentsDir.path);

    await box.put(movie.id, movie.toJson()); // Use movie ID as the key
    log("Movie saved: ${movie.title}");
  }

  // Retrieve all saved movies
  static Future<List<Movie>> getMovies() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kMoviesKey, path: appDocumentsDir.path);

    // Get all values from the box
    List<Movie> movies = [];

    // Iterate over all keys in the box
    for (var key in box.keys) {
      var json = box.get(key);
      if (json != null) {
        movies.add(Movie.fromJson(json)); // Deserialize and add to list
      }
    }

    return movies;
  }

  // Clear all saved films from local storage
  static Future<void> clearSavedFilms() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the box directly
    var box = await Hive.openBox<Map>(kMoviesKey, path: appDocumentsDir.path);
    await box.clear(); // Clears all entries in the box
    print("All saved films have been cleared.");
  }
}
