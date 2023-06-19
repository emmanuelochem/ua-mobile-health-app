import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class MyAccountOptionTile extends StatelessWidget {
  String title;
  IconData icon;
  bool actionRequired;
  VoidCallback onTap;

  MyAccountOptionTile({
    Key key,
    @required this.title,
    this.actionRequired = false,
    this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: UIColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: UIColors.secondary500,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: UIColors.secondary300,
              ),
            ),
            SizedBox(
              width: 0.04.sw,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0.021.sh,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: UIColors.secondary500,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title,
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontSize: 16.sp,
                            color: UIColors.secondary200,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
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
                              color: UIColors.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'NGN 3,000',
                              style: TypographyStyle.captionSmall.copyWith(
                                fontSize: 12.sp,
                                color: UIColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : Icon(
                            PhosphorIcons.caret_right,
                            size: 0.02.sh,
                            color: UIColors.secondary400,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
