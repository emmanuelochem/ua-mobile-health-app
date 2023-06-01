import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/notice_dialog.dart';

class OptionsDialog {
  static Future<void> messageDialog(BuildContext context, String heading,
      String content, Function accept) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => ImportantNoticeDialog(
            buttonSize: ButtonSizes.small,
            buttonBackgroundColor: UIColors.primary,
            buttonShape: ButtonShape.squircle,
            buttonTextColor: UIColors.white,
            svgFilePath: 'assets/icons/danger_notice.png',
            buttonAction: accept,
            buttonText: 'Okay, Got It!',
            title: heading,
            message: content,
            secondButtonShape: ButtonShape.squircle,
            secondButtonSize: ButtonSizes.large,
            secondButtonBackgroundColor: UIColors.primary500,
            secondButtonTextColor: UIColors.primary,
            dialogBackground: UIColors.white,
            secondButtonText: 'No, please',
            secondButtonAction: () {
              Navigator.pop(context);
            }));
    // showDialog<void>(
    //   context: context,
    //   barrierDismissible: true, // user must tap button!
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       // ignore: prefer_const_constructors
    //       title: Text(
    //         heading,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    //       ),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text(
    //               content,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(fontSize: 13),
    //             ),
    //             const SizedBox(height: 20),
    //             FlatButton(
    //               color: Theme.of(context).primaryColor,
    //               textColor: Colors.white,
    //               onPressed: accept,
    //               child: Text("Yes"),
    //             ),
    //             FlatButton(
    //               color: Colors.red,
    //               textColor: Colors.white,
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text("No"),
    //             )
    //           ],
    //         ),
    //       ),
    //       // actions: <Widget>[
    //       //   TextButton(
    //       //     child: Text('Ok'),
    //       //     onPressed: () {
    //       //       Navigator.pushNamed(context, '/login');
    //       //     },
    //       //   ),
    //       // ],
    //     );
    //   },
    // );
  }

  // static Future<void> alertDialog(
  //     BuildContext context, String heading, String content) {
  //   return showDialog<void>(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           contentPadding: const EdgeInsets.all(0),
  //           content: NikeAlertDialog(
  //             colored: true,
  //             color: Colors.red,
  //             icon: Icon(
  //               MaterialCommunityIcons.alert,
  //               size: 40,
  //               color: Colors.white,
  //             ),
  //             isIcon: true,
  //             heading: heading,
  //             message: content,
  //             action: () {
  //               Navigator.pop(context);
  //             },
  //             actionText: 'Ok',
  //           ),
  //         );
  //       });
  // }
}
