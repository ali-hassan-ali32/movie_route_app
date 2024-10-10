import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/classes.dart';
import '../taps/watchlist/manager/bloc/watch_list_cubit.dart';
import '../taps/watchlist/manager/bloc/watch_list_states.dart';

class CustomAddBottom extends StatefulWidget {
  const CustomAddBottom({super.key, required this.movie});

  final Movie? movie;
  @override
  State<CustomAddBottom> createState() => _CustomAddBottomState();
}

class _CustomAddBottomState extends State<CustomAddBottom> {
  @override
  Widget build(BuildContext context) {
    WatchListCubit watchListCubit = WatchListCubit.get(context);
    bool isInSaved = watchListCubit.isMovieSaved(widget.movie!);

    return BlocListener<WatchListCubit, WatchListState>(
        listener: (context, state) {},
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (isInSaved) {
                watchListCubit.deleteSavedMovie(widget.movie!);
                watchListCubit.removeMovieFromSavedWatchList(widget.movie);
                watchListCubit.removeMovieFromWatchList(widget.movie);
                // watchListCubit
                //     .removeMovieFromWatchList(widget.movie!);
                // watchListCubit.deleteSavedMovie(widget.movie!);


                // watchListCubit.removeMovieFromSavedWatchList(widget.movie!);
                toastification.show(
                  context: context,
                  // optional if you use ToastificationWrapper
                  title: const Text('Film has been removed successfuly'),
                  backgroundColor: Colors.orange,
                  type: ToastificationType.success,
                  // style:ToastificationStyle.fillColored,
                  // animationDuration: Duration(seconds: 2),
                  autoCloseDuration: const Duration(seconds: 2),
                );
              } else {
                watchListCubit.addMovieToWatchList(widget.movie!);
                toastification.show(
                  context: context,
                  // optional if you use ToastificationWrapper
                  title: const Text('Film has been added successfuly'),
                  backgroundColor: Colors.orange,
                  type: ToastificationType.success,
                  // style:ToastificationStyle.fillColored,
                  // animationDuration: Duration(seconds: 2),
                  autoCloseDuration: const Duration(seconds: 2),
                );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor:
                isInSaved ? Theme.of(context).primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: isInSaved
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(35.sw, 6.sh),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isInSaved ? 'Remove' : 'Add',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: isInSaved ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.bookmark,
                size: 20.sp,
                color: isInSaved ? Colors.black : Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
