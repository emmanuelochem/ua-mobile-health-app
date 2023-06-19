import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';

enum FlushbarType { success, error, warning, hint }

class FlushBar {
  static Future showSnackBar(
      {BuildContext context, String message, FlushbarType type}) {
    return Flushbar(
      backgroundColor: type == FlushbarType.success
          ? UIColors.primary500
          : type == FlushbarType.error
              ? Colors.red[100]
              : type == FlushbarType.hint
                  ? Colors.blue[400]
                  : Colors.yellow[400],
      margin: EdgeInsets.symmetric(horizontal: 0.040.sw, vertical: 60),
      borderRadius: 10.r,
      // message: message.toString(),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 5),
      borderColor: type == FlushbarType.success
          ? UIColors.primary200
          : type == FlushbarType.error
              ? Colors.red[300]
              : type == FlushbarType.hint
                  ? Colors.blue[300]
                  : Colors.yellow[300],
      //title: 'yuiuuuu',
      messageText: Text(
        message.toString(),
        textAlign: TextAlign.left,
        style: TypographyStyle.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: type == FlushbarType.success
              ? UIColors.primary
              : type == FlushbarType.error
                  ? Colors.red
                  : type == FlushbarType.hint
                      ? Colors.blue[100]
                      : Colors.yellow[100],
        ),
      ),
      // messageColor: UIColors.secondary100,
      icon: SizedBox(
        height: 0.030.sh,
        child: Icon(
          type == FlushbarType.success
              ? PhosphorIcons.check
              : type == FlushbarType.warning
                  ? PhosphorIcons.warning
                  : type == FlushbarType.error
                      ? PhosphorIcons.x
                      : PhosphorIcons.info,
          color: type == FlushbarType.success
              ? UIColors.primary
              : type == FlushbarType.error
                  ? Colors.red
                  : type == FlushbarType.hint
                      ? Colors.blue[100]
                      : Colors.yellow[100],
        ),
      ),
    ).show(context);
  }
}
