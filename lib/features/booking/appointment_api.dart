import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/network/network_handler.dart';

class DoctorAppointmentApi extends NetworkHandler {
//Students
  Future<Map> getDoctorAppointmentsByDate(
      {String doctorId, String date, BuildContext context}) async {
    String route = 'appointments/$doctorId/$date';
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

  Future<Map> bookAppointment(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'appointments';
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

  Future<Map> getAppointment({BuildContext context}) async {
    String route = 'appointments';
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

  Future<Map> getAppointmentById(
      {BuildContext context, String appointmentId}) async {
    String route = 'appointments/$appointmentId';
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

  Future<Map> cancelAppointment({
    BuildContext context,
    Map<String, dynamic> data,
  }) async {
    String route = 'appointments/cancel';
    Map<String, dynamic> header = {};
    return await httpPatch(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: true,
      context: context,
    );
  }

  Future<Map> completeAppointment({
    BuildContext context,
    Map<String, dynamic> data,
  }) async {
    String route = 'appointments/approve';
    Map<String, dynamic> header = {};
    return await httpPatch(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      successSnacbar: false,
      alertDialog: true,
      context: context,
    );
  }
}
