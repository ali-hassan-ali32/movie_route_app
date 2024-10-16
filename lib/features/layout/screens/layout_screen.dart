import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_cubit.dart';
import 'package:movie_route_app/features/layout/taps/home/manager/bloc/home_state.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/widgets/custom_bg.dart';
import '../taps/browse/screens/browse_screen.dart';
import '../taps/home/manager/cache/cache_helper.dart';
import '../taps/home/screens/home_screen.dart';
import '../taps/search/screens/search_screen.dart';
import '../taps/watchlist/watchlist_screen.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName = 'LayoutScreen';

  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => current is InitalHomeState,
        listener: (context, state) {
          setState(() {});
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: HomeCubit.get(context).selectedTap,
            onTap: (value) {
              HomeCubit.get(context).onTapPress(value);
              // CacheHelper.getMovies();
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: kPrimalyColor,
                unselectedColor: Colors.grey,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Search"),
                selectedColor: kPrimalyColor,
                unselectedColor: Colors.grey,
              ),
              SalomonBottomBarItem(
                icon:
                    const ImageIcon(AssetImage("assets/icons/movie_icon.png")),
                title: const Text("Browse"),
                selectedColor: kPrimalyColor,
                unselectedColor: Colors.grey,
              ),
              SalomonBottomBarItem(
                icon: const ImageIcon(
                    AssetImage("assets/icons/Icon ionic-md-bookmarks.png")),
                title: const Text("WatchList"),
                selectedColor: kPrimalyColor,
                unselectedColor: Colors.grey,
              ),
            ],
          ),
          body: screens[HomeCubit.get(context).selectedTap],
        ),
      ),
    );
  }

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BrowseScreen(),
    const WatchListScreen(),
  ];
}
