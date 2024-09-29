import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../layout/screens/layout_screen.dart';

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
            context, LayoutScreen.routeName, (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121312),
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
        ));
  }
}
