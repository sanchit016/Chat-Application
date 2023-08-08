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
        if (window.localStorage['id'] == null) {
          loggedIn = false;
          notifyListeners();
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

  void onPressedLogin() async {
    final response = await ApiService.instance
        .login(password: password.text, username: username.text);
    response.fold(
      (l) => {
        Fluttertoast.showToast(msg: l.message.isNotNull ? l.message! : "Error"),
      },
      (r) => {
        log.i(r),
        window.localStorage['id'] = r,
        window.localStorage['username'] = username.text,
        navigationService.clearStackAndShow(Routes.homeView),
      },
    );
  }

  void onPressedSignUp() async {
    final response = await ApiService.instance.signup(
        email: email.text, password: password.text, username: username.text);
    response.fold(
      (l) => {
        Fluttertoast.showToast(msg: l.message.isNotNull ? l.message! : "Error"),
      },
      (r) => {
        log.i(r),
        window.localStorage['id'] = r,
        window.localStorage['username'] = username.text,
        navigationService.clearStackAndShow(Routes.homeView),
      },
    );
  }
}
