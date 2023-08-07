part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();
  final log = getLogger("SplashViewModel");
  bool showSignUp = false;
  bool showLogIn = false;
  bool loggedIn = true;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  init() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setBusy(true);
        log.i(localStorageService.read("uid"));
        if (localStorageService.read("uid") == null) {
          loggedIn = false;
          notifyListeners();
          // navigationService.navigateTo(Routes.onboardingView);
          setBusy(false);
        } else {
          navigationService.clearStackAndShow(Routes.homeView);
          setBusy(false);
        }
      },
    );
  }

  showLogin() {
    showLogIn = true;
    showSignUp = false;
    notifyListeners();
  }

  showSignup() {
    showLogIn = false;
    showSignUp = true;
    notifyListeners();
  }

  void onPressedLogin() {}

  void onPressedSignUp() async {
    final response = await ApiService.instance.signup(
        email: email.text, password: password.text, username: username.text);
    response.fold(
      (l) => Fluttertoast.showToast(msg: l.message.isNotNull ? l.message! : ""),
      (r) => {navigationService.navigateTo(Routes.homeView)},
    );
  }
}
