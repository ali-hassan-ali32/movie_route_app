import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_route_app/features/layout/screens/fetch_home_data_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

import 'core/utils/constants.dart';
import 'features/layout/bloc/movie_details_cubit.dart';
import 'features/layout/screens/layout_screen.dart';
import 'features/layout/taps/browse/manager/bloc/browse_cubit.dart';
import 'features/layout/taps/home/manager/bloc/home_cubit.dart';
import 'features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => BrowseCubit(),),
      BlocProvider(create: (context) => MovieDetailsCubit(),),
    BlocProvider(create: (context) => WatchListCubit()..getSavedMovies()),
    BlocProvider(
      create: (context) => HomeCubit()..getHomePageMoviesData(),
    )
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return ToastificationWrapper(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: kPrimalyColor),
            title: 'Movies App Route',
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              LayoutScreen.routeName: (_) => const LayoutScreen(),
              FetchHomeDataScreen.routeName: (_) => const FetchHomeDataScreen(),
            },
            initialRoute: SplashScreen.routeName,
          ),
        );
      },
    );
  }
}
