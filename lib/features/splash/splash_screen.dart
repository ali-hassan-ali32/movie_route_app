import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie_route_app/core/utils/widgets/custom_bg.dart';
import 'package:movie_route_app/features/layout/screens/fetch_home_data_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamedAndRemoveUntil(
            context, FetchHomeDataScreen.routeName, (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              ZoomIn(
                  duration: const Duration(seconds: 2),
                  child: Center(child: Image.asset('assets/images/logo.png'))),
              const Spacer(
                flex: 1,
              ),
              Image.asset('assets/images/secound-logo.png')
            ],
          )),
    );
  }
}
