import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/doctors/auth/dropdown_list_tile.dart';
import 'package:ua_mobile_health/doctors/auth/dropdown_model.dart';
import 'package:ua_mobile_health/doctors/auth/form_search_input.dart';

class DropdownBottomsheet extends StatefulWidget {
  DropdownBottomsheet(
      {Key key,
      @required this.optionList,
      this.title,
      this.showSearch = false,
      this.searchPlaceholder})
      : super(key: key);

  String title;
  List<DropdownModel> optionList;
  final bool showSearch;
  final String searchPlaceholder;

  @override
  State<DropdownBottomsheet> createState() => _DropdownBottomsheetState();
}

class _DropdownBottomsheetState extends State<DropdownBottomsheet> {
  List<DropdownModel> filterList;
  @override
  void initState() {
    super.initState();
    filterList = widget.optionList;
  }

  searchList(String value) {
    if (value.isNotEmpty) {
      filterList = [];
      for (var option in widget.optionList) {
        if (option.name.toLowerCase().contains(value.toLowerCase())) {
          filterList.add(option);
        }
      }
    } else {
      filterList = widget.optionList;
    }
    setState(() {});
  }

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
                height: 0.25.sh,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.023.sh, vertical: 0.015.sh),
                  child: Text('Close',
                      textAlign: TextAlign.end,
                      style: TypographyStyle.bodyMediumn
                          .copyWith(color: UIColors.white)),
                ),
              ),
              Container(
                height: 0.65.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: UIColors.secondary600,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30.r),
                        topEnd: Radius.circular(30.r))),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.058.sw, vertical: 0.04.sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title.toString(),
                          style: TypographyStyle.heading5
                              .copyWith(fontSize: 20.sp)),
                      SizedBox(
                        height: 0.025.sh,
                      ),
                      widget.showSearch
                          ? Column(
                              children: [
                                SearchInputField(
                                  hintText:
                                      widget.searchPlaceholder ?? 'Search here',
                                  onFieldChange: (input) => searchList(input),
                                ),
                                SizedBox(
                                  height: 0.0014.sh,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      filterList.isEmpty
                          ? SizedBox(
                              child: Text('No options given',
                                  style: TypographyStyle.heading5
                                      .copyWith(fontSize: 14.sp)),
                            )
                          : SizedBox(
                              height: 0.45.sh,
                              child: ListView.builder(
                                itemCount: filterList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return DropDownListTile(
                                    item: filterList[i],
                                    callback: (result) {
                                      Navigator.pop(context, result);
                                      return result;
                                    },
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
