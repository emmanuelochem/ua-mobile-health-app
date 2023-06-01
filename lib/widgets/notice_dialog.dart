// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';

class ImportantNoticeDialog extends StatelessWidget {
  ImportantNoticeDialog(
      {Key key,
      this.svgFilePath,
      this.message,
      @required this.buttonText,
      @required this.buttonAction,
      @required this.buttonShape,
      @required this.buttonSize,
      @required this.buttonTextColor,
      @required this.buttonBackgroundColor,
      this.buttonFontSize,
      //
      this.title,
      this.iconHeight,
      this.titleFontSize,
      this.messageFontSize,
      //
      this.secondButtonText,
      this.secondButtonAction,
      this.secondButtonShape,
      this.secondButtonSize,
      this.secondButtonTextColor,
      this.secondButtonBackgroundColor,
      this.secondButtonFontSize,
      this.dialogBackground,
      this.titleMessageSpace})
      : super(key: key);

  String svgFilePath;
  String message;
  String buttonText;
  Function buttonAction;
  ButtonShape buttonShape;
  ButtonSizes buttonSize;
  final Color buttonBackgroundColor;
  Color buttonTextColor = UIColors.white;
  final double buttonFontSize;
  String title;
  double iconHeight;
  double titleFontSize;
  double messageFontSize;

  String secondButtonText;
  Function secondButtonAction;
  ButtonShape secondButtonShape;
  ButtonSizes secondButtonSize;
  final Color secondButtonBackgroundColor;
  Color secondButtonTextColor = UIColors.primary;
  final double secondButtonFontSize;
  final double titleMessageSpace;

  Color dialogBackground;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: ClipRect(
          clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50,
              sigmaY: 50,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: dialogBackground ??
                    const Color.fromARGB(255, 241, 238, 238),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: 0.041.sh, horizontal: 0.041.sh),
                child: Column(
                  children: [
                    svgFilePath != null
                        ? SizedBox(
                            height: iconHeight ?? 0.088.sh,
                            child: Image.asset(
                              svgFilePath.toString(),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                    title != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Text(
                                title.toString(),
                                textAlign: TextAlign.center,
                                style: TypographyStyle.heading4
                                    .copyWith(fontSize: titleFontSize ?? 27.sp),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    message != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: titleMessageSpace ?? 0.02.sh,
                              ),
                              Text(
                                message.toString(),
                                textAlign: TextAlign.center,
                                style: TypographyStyle.bodyLarge.copyWith(
                                    fontSize: messageFontSize ?? 17.5.sp),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 0.047.sh,
                    ),
                    ActionButton(
                      text: buttonText.toString(),
                      shape: buttonShape,
                      size: buttonSize,
                      textColor: buttonTextColor,
                      backgroundColor: buttonBackgroundColor,
                      fontSize: buttonFontSize,
                      onPressed: buttonAction,
                    ),
                    secondButtonAction != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: 0.015.sh,
                              ),
                              ActionButton(
                                text: secondButtonText.toString(),
                                shape: secondButtonShape,
                                size: secondButtonSize,
                                textColor: secondButtonTextColor,
                                backgroundColor: secondButtonBackgroundColor,
                                fontSize: secondButtonFontSize,
                                onPressed: secondButtonAction,
                              ),
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
