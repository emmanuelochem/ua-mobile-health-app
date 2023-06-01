import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoBack extends StatelessWidget {
  const GoBack({this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/navigator_back.svg',
            height: 0.016.sh,
          ),
          onPressed: () => route == null
              ? Navigator.maybePop(context)
              : Navigator.pushNamed(context, route.toString())),
    );
  }
}
