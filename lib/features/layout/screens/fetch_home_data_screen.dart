import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/core/utils/widgets/custom_bg.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_cubit.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_state.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_bad_internet_handler.dart';
import 'layout_screen.dart';

class FetchHomeDataScreen extends StatelessWidget {
  static const String routeName = 'FetchHomeDataScreen';

  const FetchHomeDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetHomeMoviesDataLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home-loading-logo.png',
                    width: 32.w,
                    height: 32.w,
                  ),
                  const Row(),
                  SizedBox(
                      width: 32.w,
                      child: const LinearProgressIndicator(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ))
                ],
              );
            } else if (state is GetHomeMoviesDataSuccses ||
                state is InitalHomeState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LayoutScreen.routeName, (route) => false);
              });

              return const SizedBox.shrink();
            } else {
              return CustomBadInternetHandler(
                onTryAgainTap: () =>
                    HomeCubit.get(context).getHomePageMoviesData(),
              );
            }
          },
        ),
      ),
    );
  }
}
