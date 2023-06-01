import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_handler.dart';

class MeetingApi extends NetworkHandler {
//Students
  Future<Map> startMeeting(
      {Map<String, dynamic> data = const {}, BuildContext context}) async {
    String route = 'meeting/start';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> joinMeeting({String meetingId, BuildContext context}) async {
    String route = 'meeting/join?meetingId=$meetingId';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: false,
      context: context,
    );
  }
}
