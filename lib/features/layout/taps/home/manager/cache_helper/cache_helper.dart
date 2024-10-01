
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:movie_route_app/core/models/movie_details/movie_details_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/utils/classes.dart';

class CacheHelper{

 static Future<void> saveFilms(Movie movie)async{
   final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

   final collection = await BoxCollection.open(
      'Fims', // Name of your database
      {'SavedFilms'},
     path: appDocumentsDir.path// Names of your boxes
       // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    final catsBox =await collection.openBox<Map>('SavedFilms');

    await catsBox.put("movie", movie.toJson());
    print(catsBox);
  }
  static List<Movie> movies=[];

 static Future<List<Movie>> getMovies()async{

   final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

   final collection = await BoxCollection.open(
     'Films', // Name of your database
     {'SavedFilms'}, // Names of your boxes
     path: appDocumentsDir.path, // Path where to store your boxes (Only used in Flutter / Dart IO)
   );

   final catsBox =await collection.openBox<Map>('SavedFilms');

   var json= await catsBox.get("movie");

     movies.add( Movie?.fromJson(json));
     print(movies);
     print("==============");
     return movies;

 }
}