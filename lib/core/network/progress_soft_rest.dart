import 'package:dio/dio.dart';

abstract class IProgressSoftRest {
  Future<Response> get(String url);
}

class ProgressSoftRest implements IProgressSoftRest {
  final Dio _dio;

  ProgressSoftRest(this._dio) {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com/";
  }

  @override
  Future<Response> get(String url) async {
    try {
      final Future<Response> getMethod = _dio.get(url);

      return await getMethod;
    } on Response catch (e) {
      return e;
    }
  }
}
