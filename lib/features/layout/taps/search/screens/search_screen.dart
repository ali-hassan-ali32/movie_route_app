import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../manager/bloc/search_cubit.dart';
import '../manager/bloc/search_states.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/movie_search_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Column(
        children: [
          const CustomSearchBar(),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                SearchCubit searchCubit = SearchCubit.get(context);
                if (state is GetSearchMoviesLoading) {
                  return const CustomLoadingWidget();
                }
                else if (state is GetSearchMoviesSuccses) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchCubit.searchList.length,
                    itemBuilder: (context, index) {
                      return MovieItem(movie: searchCubit.searchList[index]);
                    },
                  );
                }
                else if (state is InitalSearchState) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fastfood_outlined,
                        size: 40.sp,
                        color: kPrimalyColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick up some food and get ready for the movies night',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ));
                }
                else if (state is GetSearchMoviesNotFoundState) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_movies_outlined,
                        size: 40.sp,
                        color: kPrimalyColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No Movie With That Title',
                        style: TextStyle(
                          fontSize: 16.5.sp,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ));
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
            ),
          )
        ],
      ),
    );
  }
}
