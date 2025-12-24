import 'package:get_it/get_it.dart';

import '../network/api_helper.dart';
import '../../app screens/home/data/repositories/home_repository.dart';
import '../../app screens/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  
  sl.registerLazySingleton<ApiHelper>(() => ApiHelper());

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl()),
  );

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(sl()),
  );
}
