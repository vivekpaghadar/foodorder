import 'package:dio/dio.dart';
import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/network/dio_client.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(UserApi(dioClient: getIt<DioClient>()));
}
