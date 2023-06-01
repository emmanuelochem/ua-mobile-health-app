import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';

class AuthorizationInterceptor extends Interceptor {
  bool authRequired = false;
  AuthorizationInterceptor({@required bool auth}) {
    authRequired = auth;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_needAuthorizationHeader()) {
      var authToken = await GeneralLogics.getToken();
      log(authToken);
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Connection'] = 'keep-alive';
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  bool _needAuthorizationHeader() {
    if (authRequired) {
      return true;
    } else {
      return false;
    }
  }
}
