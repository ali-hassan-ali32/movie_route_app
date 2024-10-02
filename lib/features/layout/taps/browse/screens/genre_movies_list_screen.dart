import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../../home/widgets/home_movies_list_item.dart';
import '../manager/bloc/browse_cubit.dart';
import '../manager/bloc/browse_states.dart';

class GenreMoviesListScreen extends StatefulWidget {
  const GenreMoviesListScreen({super.key,required this.title,required this.genreId});

  final String title;
  final num? genreId;

  @override
  State<GenreMoviesListScreen> createState() => _GenreMoviesListScreenState();
}

class _GenreMoviesListScreenState extends State<GenreMoviesListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<BrowseCubit>(context).getFilteredMovies(genreId: widget.genreId);
    }
    );
    super.initState();
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
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.sp
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).primaryColor)),
        ),
        body: BlocBuilder<BrowseCubit, BrowseState> (
          builder: (context, state) {
            if (state is GetBrowseMoviesLoading) {
              return const CustomLoadingWidget();
            }
            else if (state is GetBrowseMoviesSuccses || state is InitalBrowseState) {
              // Home Page
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 18.w / 130,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: BlocProvider.of<BrowseCubit>(context).currentFilteredMovies.length,
                itemBuilder: (context, index) {
                  return HomeMoviesListItem(movie: BlocProvider.of<BrowseCubit>(context).currentFilteredMovies[index],);
                },
              );
            }
            else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.do_not_disturb_alt_rounded,
                      color: kPrimalyColor,
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
        )
    );
  }
}
