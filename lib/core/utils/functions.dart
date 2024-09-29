import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../main.dart';

void failureNotifcation() {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: const Text(
      'No Connection',
      style: TextStyle(
          color: Colors.white
      ),
    ),
    // you can also use RichText widget for title and description parameters
    description: const Text('Please Check Internet Connection',style: TextStyle(color: Colors.white),),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(Icons.signal_wifi_bad,color: Colors.white,),
    primaryColor: Colors.red,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    showProgressBar: false,
    applyBlurEffect: true,
  );
}

void onWatchPress() {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: const Text(
      'Not Available',
      style: TextStyle(
          color: Colors.white
      ),
    ),
    // you can also use RichText widget for title and description parameters
    description: const Text('This Feacture is Not Available Yet',style: TextStyle(color: Colors.white),),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(Icons.warning,color: Colors.white,),
    primaryColor: customOrange,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    showProgressBar: false,
    applyBlurEffect: true,
  );
}
