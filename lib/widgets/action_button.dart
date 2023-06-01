import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';

enum ButtonSizes {
  xxxxxm,
  xxxxm,
  xxxm,
  xxm,
  xm,
  small,
  medium,
  large,
}

enum ButtonShape {
  capsule,
  squircle,
}

class ActionButton extends StatelessWidget {
  ActionButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.size,
    this.leftIconPath,
    this.rightIconPath,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.shape,
    this.iconColor,
    this.fontSize,
    this.isLoading,
    this.loaderColor,
  }) : super(key: key);
  final GestureTapCallback onPressed;
  final String text;
  final double fontSize;
  final ButtonSizes size;
  final String leftIconPath;
  final String rightIconPath;
  final Color backgroundColor;
  Color textColor = UIColors.white;
  Color iconColor = UIColors.secondary;
  ButtonShape shape = ButtonShape.capsule;
  final bool isLoading;
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
                const Size.fromWidth(double.infinity)),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return backgroundColor.withOpacity(0.4);
                } else {
                  return isLoading == true
                      ? backgroundColor.withOpacity(0.4)
                      : backgroundColor;
                }
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    shape == ButtonShape.capsule ? 50.r : 8.4.r),
                // side: BorderSide(color: Colors.red),
              ),
            ),
          ),
          onPressed: isLoading == true
              ? null
              : () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  onPressed();
                },
          child: Container(
            padding: size == ButtonSizes.xxxxxm
                ? EdgeInsets.symmetric(
                    horizontal: 0.0018.sw, vertical: 0.0003.sh)
                : size == ButtonSizes.xxxxm
                    ? EdgeInsets.symmetric(
                        horizontal: 0.0018.sw, vertical: 0.0005.sh)
                    : size == ButtonSizes.xxxm
                        ? EdgeInsets.symmetric(
                            horizontal: 0.0018.sw, vertical: 0.001.sh)
                        : size == ButtonSizes.xxm
                            ? EdgeInsets.symmetric(
                                horizontal: 0.0018.sw, vertical: 0.002.sh)
                            : size == ButtonSizes.xm
                                ? EdgeInsets.symmetric(
                                    horizontal: 0.0018.sw, vertical: 0.004.sh)
                                : size == ButtonSizes.small
                                    ? EdgeInsets.symmetric(
                                        horizontal: 0.0018.sw,
                                        vertical: 0.006.sh)
                                    : size == ButtonSizes.medium
                                        ? EdgeInsets.symmetric(
                                            horizontal: 0.0018.sw,
                                            vertical: 0.0075.sh)
                                        : EdgeInsets.symmetric(
                                            horizontal: 0.0018.sw,
                                            vertical: 0.009.sh),
            width: double.infinity,
            child: isLoading == true
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.020.sh,
                        height: 0.020.sh,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            loaderColor ?? Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        leftIconPath != null
                            ? Wrap(
                                children: [
                                  SvgPicture.asset(
                                    leftIconPath,
                                    color: iconColor,
                                  ),
                                  SizedBox(
                                    width: 0.02.sw,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        Text(
                          text.toString(),
                          textAlign: TextAlign.center,
                          style: TypographyStyle.buttonSmall.copyWith(
                            color: textColor,
                            fontSize: fontSize ?? 17.sp,
                          ),
                        ),
                        rightIconPath != null
                            ? Wrap(
                                children: [
                                  SizedBox(
                                    width: 0.02.sw,
                                  ),
                                  SvgPicture.asset(
                                    rightIconPath,
                                    color: iconColor,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
