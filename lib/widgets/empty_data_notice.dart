import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class EmptyDataNotice extends StatelessWidget {
  const EmptyDataNotice({Key key, @required this.icon, @required this.message})
      : super(key: key);
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 0.4.sw,
                color: UIColors.primary100,
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Text(message,
                  textAlign: TextAlign.center,
                  style: TypographyStyle.bodySmall
                      .copyWith(fontSize: 20.sp, color: UIColors.primary100))
            ],
          ),
        ),
      ),
    ));
  }
}
