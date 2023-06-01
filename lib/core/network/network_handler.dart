import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/network/network_config.dart';
import 'package:ua_mobile_health/core/network/network_interceptor.dart';
import 'package:ua_mobile_health/core/network/network_logger.dart';
import 'package:ua_mobile_health/widgets/snack_bar.dart';

class NetworkHandler {
  //Config Url
  String apiUrl = NetworkConfig.baseUrl;

  Future httpGet({
    @required String route,
    Map<String, dynamic> header,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    //try {
    return await dio
        .get(
      route,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
        'Your request timed out, try again',
        FlushbarType.error,
        context,
      );
      GeneralLogics.showAlertNew(
        context,
        'Request Failed',
        'Your request timed out, try again',
        'sad',
      );
      return null;
    }).then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        } else if (hasCustomUrl == true) {
          return response.data;
        } else {
          GeneralLogics.showAlertNew(
              context, 'Request Failed', response.data["message"], 'sad');
          return null;
        }
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    });
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpPost({
    @required String route,
    Map<String, dynamic> header,
    @required Map<String, dynamic> data,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    //try {
    return await dio
        .post(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      //log(response.toString());
      if (response != null) {
        if (response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    }).catchError((error) {
      //log(error.toString());
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    });
  }

  Future httpPatch(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false,
      bool alertDialog = false,
      bool successSnacbar = false,
      @required BuildContext context}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    //try {
    return await dio
        .patch(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
          'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future imageUpload(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false,
      bool alertDialog = false,
      bool successSnacbar = false,
      @required BuildContext context}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    //String formData = jsonEncode(data);
    FormData formData = FormData.fromMap(data);
    //try {
    return await dio
        .post(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
          'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpDelete({
    @required String route,
    Map<String, dynamic> header,
    @required Map<String, dynamic> data,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    String formData = jsonEncode(data);
    // try {
    return await dio
        .delete(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
          'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      if (response != null) {
        if (response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please try again later or even check your internet connection.",
          'error');
      return null;
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }
}
