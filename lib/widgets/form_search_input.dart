import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/form_schemes.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class SearchInputField extends StatefulWidget {
  const SearchInputField({
    Key key,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.onFieldChange,
    this.fieldTitle,
    this.sideNote,
    this.bottomMargin = true,
  }) : super(key: key);

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onFieldChange;
  final String fieldTitle;
  final String sideNote;
  final bool bottomMargin;

  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.fieldTitle == null
                  ? const SizedBox.shrink()
                  : Text(widget.fieldTitle,
                      style:
                          TypographyStyle.heading5.copyWith(fontSize: 21.sp)),
              widget.sideNote != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 0.012.sw),
                      child: Text(widget.sideNote,
                          style: TypographyStyle.bodySmall.copyWith(
                            color: UIColors.secondary300,
                          )),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 0.0095.sh,
          ),
          TextFormField(
            focusNode: focusNode,
            key: widget.fieldKey,
            obscureText: false,
            // maxLength: widget.maxLength ?? 8,
            onSaved: widget.onSaved,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onFieldChange,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 0.049.sw, vertical: 0.011.sh),
              prefixIcon: Container(
                width: 0.06.sw,
                margin: EdgeInsets.only(
                  top: 0.005.sh,
                  left: 0.017.sw,
                  right: 0.005.sw,
                  bottom: 0.005.sh,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.008.sh, vertical: 0.011.sh),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3.55.r),
                        bottomLeft: Radius.circular(3.55.r),
                        bottomRight: Radius.circular(3.55.r),
                        topRight: Radius.circular(3.55.r),
                      ),
                      child: Image.asset(
                        'assets/icons/search_icon.png',
                        height: 0.020.sh,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              border: UIFormStyle.normal,
              focusedBorder: UIFormStyle.focus,
              enabledBorder: UIFormStyle.enabled,
              errorBorder: UIFormStyle.error,
              disabledBorder: UIFormStyle.disabled,
              hintText: widget.hintText,
              labelText: widget.labelText,
              helperText: widget.helperText,
              hintStyle: TypographyStyle.bodyLarge
                  .copyWith(color: UIColors.secondary300),
              helperStyle: TypographyStyle.bodySmall,
              isDense: true,
              filled: true,
              fillColor: UIColors.white,
            ),
          ),
          SizedBox(
            height: widget.bottomMargin ? 0.020.sh : 0.sh,
          ),
        ],
      ),
    );
  }
}
