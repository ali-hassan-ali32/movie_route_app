import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'features/layout/bloc/movie_cubit.dart';
import 'features/layout/screens/layout_screen.dart';
import 'features/layout/taps/browse/manager/bloc/browse_cubit.dart';
import 'features/layout/taps/home/manager/bloc/home_cubit.dart';
import 'features/layout/taps/watchlist/manager/bloc/watch_list_cubit.dart';
import 'features/splash/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      // BlocProvider(create: (context) => MovieCubit(),),
      BlocProvider(create: (context) => BrowseCubit(),),
      BlocProvider(create: (context) => MovieDetailsCubit(),),
      BlocProvider(create: (context) => WatchListCubit(),),
      BlocProvider(create: (context) => HomeCubit()..getHomePageMoviesData(),)
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
            theme: ThemeData(primarySwatch: customOrange),
            title: 'Movies App',
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              LayoutScreen.routeName: (_) => const LayoutScreen(),
            },
            initialRoute: SplashScreen.routeName,
          ),
        );
      },
    );
  }
}

// This is the app's custom orange color
const int _orangePrimaryValue = 0xFFF4B338;
const MaterialColor customOrange = MaterialColor(
  _orangePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFF9E3),
    100: Color(0xFFFFF1B6),
    200: Color(0xFFFFE886),
    300: Color(0xFFFFE05F),
    400: Color(0xFFFFD63F),
    500: Color(_orangePrimaryValue),
    600: Color(0xFFF4A325),
    700: Color(0xFFF4931E),
    800: Color(0xFFF37C18),
    900: Color(0xFFF2690D),
  },
);
