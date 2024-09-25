// Importing necessary packages and files
//https://lightslategray-bear-191841.hostingersite.com/public/api/get_profile  // post method
//https://lightslategray-bear-191841.hostingersite.com/public/api/login  // post method
//https://lightslategray-bear-191841.hostingersite.com/public/api/dashboard  // get method

// import 'package:get/get.dart' as getx;
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:getx/helpers/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

// API Provider class for making API calls
class ApiProvider {
  late Dio dio;

  ApiProvider() {
    dio = Dio();
  }

  Future<dynamic> postAPICall(
    String url,
    FormData? formData, {
    bool passToken = true,
    // Function(int, int)? onSendProgress,
    Map<String, String>? headers,
  }) async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      // String? accessToken =
      //     await StorageService().readSecureData(Constants.accessToken);
      String? accessToken = Constants.accessToken;
      Map<String, String> headersData = {
        "accept": 'application/json',
      };
      //
      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        headersData.addAll({
          "Authorization": "Bearer $accessToken",
        });
        debugPrint("token === $accessToken");
      }

      // if (formData != null && formData.fields.isNotEmpty) {
      //   print(formData.fields);
      //   formData = encryptRequest(formData);
      // }

      var responseJson;
      try {
        final response = await dio
            .post(
              url,
              data: formData ?? {},
              // options: Options(
              //   headers: headersData,
              // ),
              // onSendProgress: onSendProgress,
            )
            .timeout(
              const Duration(seconds: 100),
            );

        print("URL ===  $url");
        print("RESPONSE CODE ===  ${response.statusCode}");
        responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }
        if (kDebugMode) {
          print("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      } on TimeoutException {
        throw FetchDataException(
            'Something went wrong, Please try again later');
      } on DioException catch (e) {
        print(e);
        // LoadingDialog.hideLoader();
        // if (e.response != null && e.response!.statusCode == 401) {
        //   await StorageService().deleteAllSecureData();
        //   getx.Get.offAllNamed(Routes.SIGN_IN);
        //   Utils.showAlertDialog(
        //     context: navState.currentContext!,
        //     title: "Authorization Error",
        //     description:
        //         "You are not authorized to access this application, Please login again.",
        //     buttons: [
        //       TextButton(
        //         style: ButtonStyle(
        //           overlayColor: MaterialStateProperty.all(
        //             AppColors.primaryColor.withOpacity(.1),
        //           ),
        //         ),
        //         onPressed: () async {
        //           getx.Get.back();
        //         },
        //         child: Text(
        //           "Ok",
        //           style: TextStyle(
        //               color: AppColors.primaryColor,
        //               fontSize: getProportionalFontSize(14),
        //               fontFamily: AppFonts.w400),
        //         ),
        //       ),
        //     ],
        //   );
        // }
      }
      return responseJson;
    } else {
      // Utils.showToast('No Internet Connection');
      return;
    }
  }

  Future<dynamic> getAPICall(
    String url, {
    Map<String, dynamic>? queryParam,
    bool passToken = true,
    Map<String, String>? headers,
  }) async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (kDebugMode) {
        debugPrint("URL === $url");
        debugPrint("BODY === $queryParam");
      }

      // String? accessToken =
      //     await StorageService().readSecureData(Constants.accessToken);

      Map<String, String> headersData = {
        "accept": 'application/json',
      };

      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        // if (accessToken != null) {
        //   headersData.addAll({
        //     "Authorization": "Bearer $accessToken",
        //   });
        //   debugPrint("token === $accessToken");
        // }
      }

      var responseJson;
      try {
        final response = await dio
            .get(
              url,
              queryParameters: queryParam,
              // data: queryParam,
              options: Options(
                headers: headersData,
              ),
            )
            .timeout(Duration(seconds: 100));

        responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }

        if (kDebugMode) {
          print("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      } on TimeoutException {
        throw FetchDataException(
            'Something went wrong, Please try again later');
      } on DioException catch (e) {
        print(e);
        // LoadingDialog.hideLoader();
        // if (e.response != null && e.response!.statusCode == 401) {
        //   await StorageService().deleteAllSecureData();
        //   getx.Get.offAllNamed(Routes.SIGN_IN);
        //   Utils.showAlertDialog(
        //     context: navState.currentContext!,
        //     title: "Authorization Error",
        //     description:
        //         "You are not authorized to access this application, Please login again.",
        //     buttons: [
        //       TextButton(
        //         style: ButtonStyle(
        //           overlayColor: MaterialStateProperty.all(
        //             AppColors.primaryColor.withOpacity(.1),
        //           ),
        //         ),
        //         onPressed: () async {
        //           getx.Get.back();
        //         },
        //         child: Text(
        //           "Ok",
        //           style: TextStyle(
        //               color: AppColors.primaryColor,
        //               fontSize: getProportionalFontSize(14),
        //               fontFamily: AppFonts.w400),
        //         ),
        //       ),
        //     ],
        //   );
        // }
      }
      return responseJson;
    } else {
      // Utils.showToast('No Internet Connection');
      return;
    }
  }

  Future<dynamic> putAPICall(
    String url,
    FormData? formData, {
    bool passToken = true,
    Function(int, int)? onSendProgress,
    Map<String, String>? headers,
  }) async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // String? accessToken =
      //     await StorageService().readSecureData(Constants.accessToken);

      Map<String, String> headersData = {
        "accept": 'application/json',
      };

      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        // if (accessToken != null) {
        //   headersData.addAll({
        //     "Authorization": "Bearer $accessToken",
        //   });
        //   debugPrint("token === $accessToken");
        // }
      }
      // if (formData != null && formData.fields.isNotEmpty) {
      //   formData = encryptRequest(formData);
      // }
      var responseJson;
      try {
        final response = await dio
            .put(url,
                data: formData ?? {},
                options: Options(
                  headers: headersData,
                ),
                onSendProgress: onSendProgress)
            .timeout(
              Duration(seconds: 100),
            );

        print(response);
        // responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }

        if (kDebugMode) {
          print("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      } on TimeoutException {
        throw FetchDataException(
            'Something went wrong, Please try again later');
      } on DioException catch (e) {
        print(e);
        // LoadingDialog.hideLoader();
        // if (e.response != null && e.response!.statusCode == 401) {
        //   await StorageService().deleteAllSecureData();
        //   getx.Get.offAllNamed(Routes.SIGN_IN);
        //   Utils.showAlertDialog(
        //     context: navState.currentContext!,
        //     title: "Authorization Error",
        //     description:
        //         "You are not authorized to access this application, Please login again.",
        //     buttons: [
        //       TextButton(
        //         style: ButtonStyle(
        //           overlayColor: MaterialStateProperty.all(
        //             AppColors.primaryColor.withOpacity(.1),
        //           ),
        //         ),
        //         onPressed: () async {
        //           getx.Get.back();
        //         },
        //         child: Text(
        //           "Ok",
        //           style: TextStyle(
        //               color: AppColors.primaryColor,
        //               fontSize: getProportionalFontSize(14),
        //               fontFamily: AppFonts.w400),
        //         ),
        //       ),
        //     ],
        //   );
        // }
      }
      return responseJson;
    } else {
      // Utils.showToast('No Internet Connection');
      return;
    }
  }

  dynamic _response(Response response) async {
    switch (response.statusCode) {
      case 200:
        var responseJson = response;
        return responseJson;
      case 400:
        // LoadingDialog.hideLoader();
        throw BadRequestException(response);
      case 401:
        // var responseJson = response.data;
        // LoadingDialog.hideLoader();
        // await StorageService().deleteAllSecureData();
        // getx.Get.offAllNamed(Routes.SIGN_IN);
        // Utils.showAlertDialog(
        //   context: navState.currentContext!,
        //   title: "Authorization Error",
        //   description:
        //       "You are not authorized to access this application, Please login again.",
        //   buttons: [
        //     TextButton(
        //       style: ButtonStyle(
        //         overlayColor: MaterialStateProperty.all(
        //           AppColors.primaryColor.withOpacity(.1),
        //         ),
        //       ),
        //       onPressed: () async {
        //         getx.Get.back();
        //       },
        //       child: Text(
        //         "Ok",
        //         style: TextStyle(
        //             color: AppColors.primaryColor,
        //             fontSize: getProportionalFontSize(14),
        //             fontFamily: AppFonts.w400),
        //       ),
        //     ),
        //   ],
        // );
        var responseJson = response;
        return responseJson;
      case 422:
        // LoadingDialog.hideLoader();
        var responseJson = response;
        return responseJson;
      case 403:
        // LoadingDialog.hideLoader();
        throw UnauthorisedException(response);
      case 500:
      default:
        // LoadingDialog.hideLoader();
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  // FormData encryptRequest(FormData formData) {
  //   FormData returnFormData = formData;
  //
  //   Map<String, dynamic> data = convertFormDataFieldsToMap(formData);
  //
  //   String plainText = jsonEncode(data);
  //   final key = encrypt.Key.fromBase64('Ot89kQekeGKYFWNGSTB/sGxW694+st5Oe+g206bNttk=');
  //   final iv = encrypt.IV.fromBase64(
  //     '+lurlFM3+uNyuW/qoJ+ZVg==',
  //   );
  //   final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  //
  //   final encrypted = encrypter.encrypt(plainText, iv: iv);
  //   returnFormData.fields.clear();
  //   returnFormData.fields.add(MapEntry('data', encrypted.base64));
  //
  //   return returnFormData;
  // }
  //
  // dynamic decryptResponse(responseJson) {
  //   final plainText = responseJson;
  //   final key = encrypt.Key.fromBase64('Ot89kQekeGKYFWNGSTB/sGxW694+st5Oe+g206bNttk=');
  //   final iv = encrypt.IV.fromBase64(
  //     '+lurlFM3+uNyuW/qoJ+ZVg==',
  //   );
  //   final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  //   final dec = encrypter.decrypt64(
  //     plainText,
  //     iv: iv,
  //   );
  //   responseJson = jsonDecode(dec);
  //
  //   return responseJson;
  // }

  Future<Map<String, String>> getDeviceInfo() async {
    Map<String, String> returnData = {};
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      returnData.addAll({
        "device_token": "Token", //FirebaseMessages().fcmToken,
        "device_type": "ANDROID",
        "version_code": packageInfo.buildNumber,
        "version_number": packageInfo.version,
        "os_version": androidInfo.version.release,
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      returnData.addAll({
        "device_token": "Token", //FirebaseMessages().fcmToken,
        "device_type": "IOS",
        "version_code": packageInfo.buildNumber,
        "version_number": packageInfo.version,
        "os_version": iosInfo.systemVersion,
      });
    }

    return returnData;
  }
}

Map<String, dynamic> convertFormDataFieldsToMap(FormData formData) {
  return formData.fields.fold<Map<String, dynamic>>({}, (map, field) {
    map[field.key] = field.value;

    return map;
  });
}

// Custom Exception classes for API error handling
class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
