import 'dart:ui';

import 'package:blog_frontend/file_exporter.dart';



class ScreenLoader {
  final log = getLogger("ScreenLoader");
  bool isLoaderActive = false;

  final _overlay =
      OverlayEntry(builder: (context) => const _ScreenLoadingWidget());

  void startLoader() {
    if (isLoaderActive) return;
    try {
      StackedService.navigatorKey!.currentState!.overlay!.insert(_overlay);
      isLoaderActive = true;
    } catch (e) {
      log.e("Error is $e");
    }
  }

  void stopLoader() {
    if (isLoaderActive) {
      isLoaderActive = false;
      _overlay.remove();
    }
  }
}

class _ScreenLoadingWidget extends StatelessWidget {
  const _ScreenLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
        child: SizedBox(
          height: context.h,
          width: context.w,
          child: const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
