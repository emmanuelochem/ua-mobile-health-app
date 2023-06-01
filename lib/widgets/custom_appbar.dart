import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key key, this.appTitle, this.route, this.icon, this.actions})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String appTitle;
  final String route;
  final Icon icon;
  final List<Widget> actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: UIColors.primary,
      elevation: 0,
      centerTitle: false,
      title: Text(
        widget.appTitle,
        style: TypographyStyle.heading5.copyWith(
          fontSize: 20.sp,
          color: UIColors.white,
        ),
      ),
      leading: widget.icon != null
          ? Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 0.010.sh, vertical: 0.010.sh),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: UIColors.secondary600.withOpacity(.5),
              ),
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (widget.route != null) {
                      Navigator.of(context).pushNamed(widget.route);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: widget.icon,
                  iconSize: 0.02.sh,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      actions: widget.actions,
    );
  }
}
