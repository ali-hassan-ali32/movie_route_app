import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../core/utils/widgets/custom_bg.dart';
import '../../../main.dart';
import '../taps/browse/screens/browse_screen.dart';
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

  int selectedTap = 0;
  @override
  Widget build(BuildContext context) {

    return CustomBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedTap,
          onTap: (value) {
            setState(() {
              selectedTap = value;
            });
          },
          items: [

            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: customOrange,
              unselectedColor: Colors.grey,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: customOrange,
              unselectedColor: Colors.grey,
            ),

            /// Browse
            SalomonBottomBarItem(
              icon: const ImageIcon(
                  AssetImage("assets/icons/movie_icon.png")),
              title: const Text("Browse"),
              selectedColor: customOrange,
              unselectedColor: Colors.grey,
            ),

            /// WatchList
            SalomonBottomBarItem(
              icon: const ImageIcon(
                  AssetImage("assets/icons/Icon ionic-md-bookmarks.png")),
              title: const Text("WatchList"),
              selectedColor: customOrange,
              unselectedColor: Colors.grey,
            ),
          ],
        ),
        body: screens[selectedTap],
      ),
    );
  }

  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchListScreen(),
  ];
}
