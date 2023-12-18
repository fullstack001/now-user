import 'package:application_1/utils/api_utils.dart';
import 'package:dio/dio.dart';

import '../../All_Refrences/shared_refrence.dart';

class DioService {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: baseUrl));
  DioService._internal();

  static final _singleton = DioService._internal();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    if (accessToken != null) {
      // var expiration = await TokenRepository().getAccessTokenRemainingTime();

      // if (expiration.inSeconds < 60) {
      // ignore: deprecated_member_use
      dio.interceptors.requestLock.lock();

      // Call the refresh endpoint to get a new token
      // await UserService().refresh().then((response) async {
      //   await TokenRepository().persistAccessToken(response.accessToken);
      //   accessToken = response.accessToken;
      // }).catchError((error, stackTrace) {
      //   handler.reject(error, true);
      // }).whenComplete(() => dio.interceptors.requestLock.unlock());
      // }

      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
