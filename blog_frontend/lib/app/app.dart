
import 'package:blog_frontend/file_exporter.dart';
import 'package:blog_frontend/services/local_storage_services.dart';
import 'package:blog_frontend/ui/views/home/home_view.dart';
import 'package:blog_frontend/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

//flutter pub run build_runner build --delete-conflicting-outputs
