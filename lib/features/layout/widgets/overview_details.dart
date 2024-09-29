import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../bloc/movie_cubit.dart';

class OverviewDetails extends StatelessWidget {
  const OverviewDetails({
    super.key,
    required this.movieDetailsCubit,
    required this.genres,
    required this.casts,
  });

  final MovieDetailsCubit movieDetailsCubit;
  final List<String?> genres;
  final List<String?> casts;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 4.sw),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              movieDetailsCubit.currentMovie?.overview ?? 'Overview Not Found',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
            const SizedBox(height: 16),
            Text(
              'Genres',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            Text(
              genres.isNotEmpty ? genres.join(', ') : 'N/A',
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
            const SizedBox(height: 10),
            Text(
              'Casts',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            Text(
              casts.isNotEmpty ? casts.join(', ') : 'N/A',
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
