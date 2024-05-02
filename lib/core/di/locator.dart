import 'package:get_it/get_it.dart';
import 'package:graduation_project/view_model/home_view_model.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
}
