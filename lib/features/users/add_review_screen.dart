import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:ua_mobile_health/core/logics/formValidationLogics.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/users/user_api.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/form_header.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key key, this.doctorId}) : super(key: key);
  final String doctorId;
  @override
  State<AddReviewScreen> createState() => _RequestChannelsScreenState();
}

class _RequestChannelsScreenState extends State<AddReviewScreen> {
  bool _isLoading = false;
  double ratingValue = 1;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.10.sh,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0.015.sh),
                  child: Text('Close',
                      textAlign: TextAlign.end,
                      style: TypographyStyle.bodyMediumn
                          .copyWith(color: UIColors.white)),
                ),
              ),
              Container(
                height: 0.80.sh,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.r),
                    topEnd: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.058.sw, vertical: 0.040.sh),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHeader(
                            title: 'Review',
                            hasCustomTitleSize: true,
                            titleFontSize: 23.sp,
                            description:
                                'Leave a review about your experience with this doctor.',
                          ),

                          Text(
                            'Instructions',
                            style: TypographyStyle.heading3.copyWith(
                              fontSize: 15.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01.sh),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Be concise, do not spam.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  '2. Be respectful, do not make use of offensive words.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  '3. Each reviews are subjective. Be honest.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 0.04.sh,
                          ),
                          Text(
                            'Swipe to rate',
                            style: TypographyStyle.bodySmall.copyWith(
                              color: UIColors.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (v) {
                              ratingValue = v;
                              setState(() {});
                            },
                            starCount: 5,
                            rating: ratingValue,
                            size: 35.0,
                            filledIconData: PhosphorIcons.star_fill,
                            halfFilledIconData: PhosphorIcons.star_half,
                            color: Colors.amber,
                            borderColor: Colors.amber,
                            spacing: 0.0,
                          ),

                          SizedBox(height: 0.02.sh),
                          TextInputField(
                            hintText: 'Comment',
                            validator: FormValidation.isEmpty,
                            textController: textEditingController,
                            inputType: InputType.textarea,
                          ),

                          SizedBox(height: 0.04.sh),
                          // const Spacer(),
                          ActionButton(
                            text: 'Submit',
                            backgroundColor: UIColors.primary,
                            textColor: UIColors.white,
                            shape: ButtonShape.squircle,
                            size: ButtonSizes.large,
                            isLoading: _isLoading,
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    UserApi userApi = UserApi();
                                    Map<String, dynamic> data = {
                                      "doctor": widget.doctorId,
                                      "rating": ratingValue,
                                      "message": textEditingController.text,
                                    };
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (context.mounted) {
                                      await userApi
                                          .addRating(
                                              data: data, context: context)
                                          .then((value) async {
                                        if (value != null) {
                                          GeneralLogics.showNotice(
                                            context: context,
                                            canDismiss: false,
                                            heading: 'Okay, Got It!',
                                            msg: value['message'],
                                            type: 'success',
                                            onContinue: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          );
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
