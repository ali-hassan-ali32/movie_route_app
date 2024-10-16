import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/objects.dart';
import '../bloc/movie_details_cubit.dart';
import '../bloc/movie_details_states.dart';
import '../widgets/custom_loading_widget.dart';
import '../widgets/movie_details.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie? movie;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<MovieDetailsCubit>(context).getMovieDetails(movieId: widget.movie?.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailsCubit movieDetailsCubit = MovieDetailsCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121312),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is GetMovieDetailsDataLoading) {
              return const CustomLoadingWidget();
            }
            else {
              return MovieDetails(
                movie: widget.movie,
                movieDetailsCubit: movieDetailsCubit,
              );
            }
          },
        ),
      ),
    );
  }
}