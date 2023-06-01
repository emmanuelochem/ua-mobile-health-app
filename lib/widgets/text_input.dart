import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/form_schemes.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';

enum InputType {
  email,
  text,
  number,
  textarea,
  password,
}

class TextInputField extends StatefulWidget {
  TextInputField(
      {Key key,
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
      this.footerNote,
      this.footerNoteColor,
      this.footerHighlightNote,
      this.footerHighlightColor,
      this.enabled = true,
      this.textController,
      this.disabledColor,
      this.hintFontSize,
      this.hintFontWeight,
      this.centerCursor = false,
      this.inputType = InputType.text,
      this.hideText = false})
      : super(key: key);

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
  final String footerNote;
  Color footerNoteColor;
  final String footerHighlightNote;
  final Color footerHighlightColor;
  final bool enabled;
  final TextEditingController textController;
  final Color disabledColor;
  final double hintFontSize;
  final FontWeight hintFontWeight;
  final bool centerCursor;
  final InputType inputType;
  final bool hideText;

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool obsecurePass = false;
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
          widget.fieldTitle != null
              ? Row(
                  children: [
                    Text(widget.fieldTitle,
                        style: TypographyStyle.bodyMediumn
                            .copyWith(fontSize: 15.sp)),
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
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 0.0055.sh,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: widget.inputType == InputType.email
                    ? TextInputType.emailAddress
                    : widget.inputType == InputType.number
                        ? const TextInputType.numberWithOptions(
                            signed: true, decimal: true)
                        : widget.inputType == InputType.textarea
                            ? TextInputType.multiline
                            : widget.inputType == InputType.password
                                ? TextInputType.visiblePassword
                                : TextInputType.text,
                textAlign:
                    widget.centerCursor ? TextAlign.center : TextAlign.start,
                maxLines: widget.inputType == InputType.textarea ? 4 : 1,
                controller: widget.textController,
                enabled: widget.enabled,
                focusNode: focusNode,
                key: widget.fieldKey,
                obscureText: obsecurePass ? obsecurePass : widget.hideText,
                onSaved: widget.onSaved,
                validator: widget.validator,
                cursorColor: UIColors.primary,
                onFieldSubmitted: widget.onFieldSubmitted,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onFieldChange,
                style: TypographyStyle.bodyLarge.copyWith(
                    color: UIColors.secondary200,
                    fontSize: widget.hintFontSize ?? 18.sp,
                    fontWeight: widget.hintFontWeight ?? FontWeight.w400),
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.email_outlined),
                  // prefixIconColor: UIColors.primary,
                  suffixIcon: widget.inputType == InputType.password
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecurePass = !obsecurePass;
                            });
                          },
                          child: !obsecurePass
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: UIColors.secondary400,
                                  size: 23.sp,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  color: UIColors.primary,
                                  size: 23.sp,
                                ),
                        )
                      : const SizedBox.shrink(),
                  alignLabelWithHint: true,
                  border: UIFormStyle.normal,
                  focusedBorder: UIFormStyle.focus,
                  enabledBorder: UIFormStyle.enabled,
                  errorBorder: UIFormStyle.error,
                  disabledBorder: UIFormStyle.disabled,
                  hintStyle: TypographyStyle.bodyLarge.copyWith(
                      color: UIColors.secondary300,
                      fontSize: widget.hintFontSize ?? 18.sp,
                      fontWeight: widget.hintFontWeight ?? FontWeight.w400),
                  helperStyle: TypographyStyle.bodySmall
                      .copyWith(color: UIColors.secondary300, fontSize: 15.sp),
                  filled: true,
                  fillColor: !widget.enabled
                      ? (widget.disabledColor ?? UIColors.secondary500)
                      : focusNode.hasFocus
                          ? UIColors.secondary600
                          : UIColors.secondary600,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.049.sw, vertical: 0.018.sh),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  helperText: widget.helperText,
                ),
              ),
              widget.footerNote != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 0.001.sh,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              widget.footerNote != null
                                  ? TextSpan(
                                      text: widget.footerNote,
                                      style:
                                          TypographyStyle.bodyMediumn.copyWith(
                                        color: widget.footerNoteColor ??
                                            UIColors.secondary300,
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  : const TextSpan(),
                              widget.footerHighlightNote != null
                                  ? TextSpan(
                                      text: widget.footerHighlightNote,
                                      style:
                                          TypographyStyle.bodyMediumn.copyWith(
                                        color: widget.footerHighlightColor,
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  : const TextSpan()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
          SizedBox(
            height: 0.020.sh,
          ),
        ],
      ),
    );
  }
}
