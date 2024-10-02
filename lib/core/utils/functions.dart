import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'constants.dart';

void failureNotifcation() {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
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
    autoCloseDuration: const Duration(seconds: 3),
    title: const Text(
      'Not Available',
      style: TextStyle(
          color: Colors.white
      ),
    ),
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
    primaryColor: kPrimalyColor,
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

void addMovieToWatchListNotifcation({required String movieTitle}) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      '$movieTitle Added',
      style: const TextStyle(color: Colors.white),
    ),
    description: Text(
      '$movieTitle Added To The Watch List Successfuly',
      style: const TextStyle(color: Colors.white),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(
      Icons.bookmark,
      color: Colors.green,
    ),
    primaryColor: kPrimalyColor,
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

void removeMovieToWatchListNotifcation({required String movieTitle}) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      '$movieTitle Removed Successfuly',
      style: const TextStyle(color: Colors.white),
    ),
    description: Text(
      '$movieTitle Removed from The Watch List',
      style: const TextStyle(color: Colors.white),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(
      Icons.delete,
      color: Colors.red,
    ),
    primaryColor: kPrimalyColor,
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

List<Color> getColorsList(Color baseColor) {
  return [
    baseColor,
    baseColor.withOpacity(0.8),
    baseColor.withOpacity(0.6),
    baseColor.withOpacity(0.4),
    baseColor.withOpacity(0.2),
  ];
}
