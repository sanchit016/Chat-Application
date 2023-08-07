import 'package:blog_frontend/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:blog_frontend/file_exporter.dart';

part 'splash_view_model.dart';
part 'splash_view_components.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(50.hWise),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Your other widgets go here
                    Image.asset(
                      "assets/img/splash.png",
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: "Blog App",
                              color: Colors.white,
                              fontSize: 60.hWise,
                              fontWeight: FontWeight.w600,
                            ),
                            AppText(
                              text: ".",
                              fontSize: 60.hWise,
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                            ),
                          ],
                        ),
                        50.hGap,
                        if (!model.loggedIn) ...[
                          Button(
                            text: "LogIn",
                            color: model.showLogIn ? Colors.grey : Colors.white,
                            onPressed: model.showLogin,
                            textColor: Colors.black,
                          ),
                          10.hGap,
                          Button(
                            text: "SignUp",
                            color:
                                model.showSignUp ? Colors.grey : Colors.white,
                            onPressed: model.showSignup,
                            textColor: Colors.black,
                          ),
                        ],
                        20.hGap,
                        AppText(
                          text: "by Sanchit Chhabra",
                          color: Colors.white,
                          fontSize: 15.hWise,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    100.wGap,
                    if (model.showLogIn) ...[
                      const LoginForm(),
                    ],
                    if (model.showSignUp) ...[
                      const SignUpForm(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onPressedLogin() {}
}
