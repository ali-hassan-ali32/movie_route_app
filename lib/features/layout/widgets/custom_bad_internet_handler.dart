import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/constants.dart';

class CustomBadInternetHandler extends StatelessWidget {
  const CustomBadInternetHandler({
    super.key,
    required this.onTryAgainTap,
  });

  final Function onTryAgainTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        ImageIcon(
          const AssetImage('assets/icons/signal_wifi.png'),
          size: 46.sp,
          color: kPrimalyColor,
        ),
        Text(
          'Bad Internet Connection!',
          style: TextStyle(color: Colors.grey, fontSize: 20.sp),
        ),
        const Spacer(
          flex: 2,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () => onTryAgainTap(),
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
