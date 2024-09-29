import 'package:flutter/material.dart';
import '../../../../../core/models/upcoming_movies/upcoming_movies_model.dart';
import '../../../../../core/utils/classes.dart';
import '../../../../../data/manager/upcoming_movies_api.dart';
import '../widgets/home_movies_list_item.dart';

class HomeMoviesListScreen extends StatefulWidget {
  const HomeMoviesListScreen({super.key, required this.title, required this.movies});

  final String title;
  final List<Movie> movies;

  @override
  _HomeMoviesListScreenState createState() => _HomeMoviesListScreenState();
}

class _HomeMoviesListScreenState extends State<HomeMoviesListScreen> {
  late List<Movie> _movies;
  bool _isLoading = false;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _movies = widget.movies;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadMoreMovies();
      }
    });
  }

  Future<void> _loadMoreMovies() async {
    if (_isLoading) return; // Prevent multiple calls if already loading

    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch the next set of movies from your API using the current page
      UpcomingMoviesModel upcomingMoviesModel = await UpcomingMoviesApi.getUpcomingMovies(page: _currentPage);
      final List<Movie> newMovies = upcomingMoviesModel.upcomingMoviesList ?? [];

      // Append new movies to the list
      if (newMovies.isNotEmpty) {
        setState(() {
          _movies.addAll(newMovies);
          _currentPage++; // Increment the page for the next fetch
        });
      }
    } catch (e) {
      // Handle errors (e.g., show a snackbar or toast)
      // Optionally notify the user of the error
    } finally {
      setState(() {
        _isLoading = false; // Move loading state reset to finally block
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 120 / 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return HomeMoviesListItem(movie: _movies[index]);
              },
            ),
          ),
          // Linear progress indicator
          if (_isLoading)
            const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
