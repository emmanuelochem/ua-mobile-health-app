import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class UIFormStyle {
  static OutlineInputBorder normal = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.sw,
      style: BorderStyle.solid,
      color: UIColors.secondary400,
    ),
  );

  static OutlineInputBorder focus = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
        width: 0.003.sw, style: BorderStyle.solid, color: UIColors.primary),
  );

  static OutlineInputBorder enabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.sw,
      style: BorderStyle.solid,
      color: UIColors.secondary400,
    ),
  );
  static OutlineInputBorder error = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.003.sw,
      style: BorderStyle.solid,
      color: UIColors.primary,
    ),
  );
  static OutlineInputBorder disabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.00.sw,
      style: BorderStyle.none,
      color: UIColors.primary,
    ),
  );
}
