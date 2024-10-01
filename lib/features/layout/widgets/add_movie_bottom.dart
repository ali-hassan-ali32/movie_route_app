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
    bool isAdded = watchListCubit.isMovieAdded(widget.movie!);

    return BlocListener<WatchListCubit, WatchListState>(
        listener: (context, state) {},
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (isAdded) {
                watchListCubit.removeMovieFromWatchList(widget.movie!);
                toastification.show(
                    context: context,
                    // optional if you use ToastificationWrapper
                    title: Text('Film has been removed successfuly'),
              backgroundColor: Colors.orange,
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 2),);
              } else {
                watchListCubit.addMovieToWatchList(widget.movie!);
                toastification.show(
                  context: context,
                  // optional if you use ToastificationWrapper
                  title: Text('Film has been added successfuly'),
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
                isAdded ? Theme.of(context).primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: isAdded
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
                isAdded ? 'Remove' : 'Add',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: isAdded ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.bookmark,
                size: 20.sp,
                color: isAdded ? Colors.black : Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
