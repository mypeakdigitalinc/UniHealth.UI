import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/error/error_store.dart';
import '../../stores/form/form_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/nav/nav_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../stores/user/user_store.dart';
import '../modules/local_module.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  // getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  // getIt.registerSingleton(DioClient(getIt<Dio>()));
  // getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  //getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));

  // data sources
  //getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
  getIt.registerSingleton(NavStore(getIt<Repository>()));
}
