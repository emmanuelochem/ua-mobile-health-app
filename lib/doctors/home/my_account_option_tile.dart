import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class MyAccountOptionTile extends StatelessWidget {
  String svgIconPath;
  String title;
  Icon icon;
  bool actionRequired;
  VoidCallback onTap;

  MyAccountOptionTile({
    Key key,
    this.svgIconPath,
    @required this.title,
    this.actionRequired = false,
    this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 3.sp,
      ),
      child: ListTile(
        visualDensity: VisualDensity(
          vertical: 2.sp,
        ),
        horizontalTitleGap: 4,
        tileColor: UIColors.secondary500,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        //dense: true,
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: UIColors.secondary400,
            shape: BoxShape.circle,
          ),
          child: icon ??
              SvgPicture.asset(
                svgIconPath,
              ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title,
                style: TypographyStyle.bodyMediumn.copyWith(
                  fontSize: 15.sp,
                )),
            actionRequired
                ? Container(
                    margin: EdgeInsets.only(
                      left: 0.022.sw,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.022.sw,
                      vertical: 0.0065.sh,
                    ),
                    decoration: BoxDecoration(
                      color: UIColors.primary500,
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    child: Text(
                      'Not Verified',
                      style: TypographyStyle.captionSmall.copyWith(
                        fontSize: 12.sp,
                        color: UIColors.primary200,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        trailing: Icon(
          PhosphorIcons.caret_right,
          size: 0.02.sh,
          color: UIColors.secondary400,
        ),
      ),
    );
  }
}
