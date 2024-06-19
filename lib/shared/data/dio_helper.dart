import 'package:klearn/shared/data/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: base_url,
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      },
    ));
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    return await dio.get(url,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.post(url,
        data: data,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.put(url,
        data: data,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
  }

  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.patch(url,
        data: data,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    return await dio.delete(url,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
  }
}