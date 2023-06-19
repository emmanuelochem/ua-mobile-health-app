import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key key, this.appTitle, this.route, this.actions})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String appTitle;
  final String route;

  final List<Widget> actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: UIColors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.appTitle,
        style: TypographyStyle.heading5.copyWith(
          fontSize: 18.sp,
          color: UIColors.secondary,
        ),
      ),
      leading: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (widget.route != null) {
              Navigator.of(context).pushNamed(widget.route);
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: SvgPicture.asset(
            'assets/icons/navigator_back.svg',
            height: 0.016.sh,
          ),
          iconSize: 0.02.sh,
          color: Colors.white,
        ),
      ),
      actions: widget.actions,
    );
  }
}
