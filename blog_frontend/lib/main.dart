import 'package:blog_frontend/file_exporter.dart';

Future<void> main() async {
  await Future.wait([
    GetStorage.init(),
  ]);

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Outfit',
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.splashView,
    );
  }
}
