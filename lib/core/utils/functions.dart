import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

import 'constants.dart';

void failureNotifcation() {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      'No Connection',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
    ),
    description: Text(
      'Please Check Internet Connection',
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
      Icons.signal_wifi_bad,
      color: Colors.white,
    ),
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
    title: Text(
      'Not Available',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
    ),
    description: Text(
      'This Feacture is Not Available Yet',
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
      Icons.warning,
      color: Colors.white,
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

void addMovieToWatchListNotifcation({required String movieTitle}) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      '$movieTitle Added Successfuly',
      textAlign: TextAlign.justify,
      style: TextStyle(
          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
    ),
    description: Text(
      '$movieTitle Added To The Watch List',
      textAlign: TextAlign.justify,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
      textAlign: TextAlign.justify,
      style: TextStyle(
          color: Colors.white, fontSize: 14.8.sp, fontWeight: FontWeight.bold),
    ),
    description: Text(
      '$movieTitle Removed from The Watch List',
      textAlign: TextAlign.justify,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
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

List<Color> getColorsList({required Color baseColor}) {
  return [
    baseColor,
    baseColor.withOpacity(0.8),
    baseColor.withOpacity(0.6),
    baseColor.withOpacity(0.4),
    baseColor.withOpacity(0.2),
  ];
}
