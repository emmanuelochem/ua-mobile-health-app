import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/constants/app_constants.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    this.review,
  }) : super(key: key);

  final Map review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: UIColors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(review['student']['photo']))),
          ),
          SizedBox(
            width: 0.040.sw,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${review['student']['firstname']} ${review['student']['lastname']}',
                            style: TypographyStyle.bodySmall.copyWith(
                                color: UIColors.secondary100,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                height: 0),
                          ),
                        ),
                        Text(
                          AppConstants.formatDate
                              .format(DateTime.parse(review['createdAt'])),
                          style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 13.sp,
                            height: 0,
                            fontWeight: FontWeight.w600,
                            color: UIColors.secondary300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.005.sh,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: List.generate(
                              review['rating'],
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 0.005.sw),
                                child: Icon(
                                  PhosphorIcons.star_fill,
                                  size: 0.014.sh,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Text(
                      '${review['message']}',
                      textAlign: TextAlign.justify,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        fontSize: 14.sp,
                        height: 0,
                        fontWeight: FontWeight.w500,
                        color: UIColors.secondary200,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
