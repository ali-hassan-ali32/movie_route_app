import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../manager/bloc/browse_cubit.dart';
import '../manager/bloc/browse_states.dart';
import '../widgets/genre_movie_item.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<BrowseCubit>(context).getMoviesGenres();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BrowseCubit cubit = BlocProvider.of<BrowseCubit>(context);

    return BlocBuilder<BrowseCubit, BrowseState>(
      builder: (context, state) {
        if (state is GetBrowseMoviesLoading) {
          return const CustomLoadingWidget();
        }
        else if (state is GetBrowseMoviesSuccses || state is InitalBrowseState) {
          return GenreMovieItem(
            genres: cubit.moviesGenres,
          );
        }
        else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.do_not_disturb_alt_rounded,
                  color: customOrange,
                  size: 40.sp,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Opps someting Wrong Happen!, try later',
                  style: TextStyle(color: Colors.grey, fontSize: 16.5.sp),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}