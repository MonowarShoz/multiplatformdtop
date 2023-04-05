import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:multiplatformdtop/util/app_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Data/Api Services/Dio/dio_client.dart';
import 'Data/Api Services/Dio/logging_interceptor.dart';

import 'Data/Provider/kormi_information_provider.dart';
import 'Data/Provider/pss_report_provider.dart';
import 'Data/Provider/user_config_provider.dart';
import 'Data/Repository/auth_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient(
        AppConstants.baseUrl,
        sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  //Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));

//Provider
  sl.registerFactory(() => UserConfigProvider(authRepo: sl()));
  // sl.registerFactory(() => AdcInformationProvider(sl()));
  sl.registerFactory(() => KormiInformationProvider(sl()));
  // sl.registerFactory(() => AreaInformationProvider(sl()));
  // sl.registerFactory(() => ChBankAccountProvider(sl()));
  sl.registerFactory(() => PssReportProvider(sl()));

  // External

  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
