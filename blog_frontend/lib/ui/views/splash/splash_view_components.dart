part of 'splash_view.dart';

class LoginForm extends ViewModelWidget<SplashViewModel> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, SplashViewModel viewModel) {
    return Container(
      width: 300.wWise,
      child: Column(
        children: [
          30.hGap,
          AppText(
            text: "Log In",
            color: Colors.white,
            fontSize: 30.hWise,
          ),
          10.hGap,
          TextField(
            controller: viewModel.username,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
              hintText: 'Enter Username',
            ),
          ),
          10.hGap,
          TextField(
            controller: viewModel.password,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter Password',
            ),
          ),
          10.hGap,
          GestureDetector(
            onTap: viewModel.onPressedLogin,
            child: Container(
              width: 40.hWise,
              height: 40.hWise,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.hWise),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_right_alt_sharp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends ViewModelWidget<SplashViewModel> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, SplashViewModel viewModel) {
    return Container(
      width: 300.wWise,
      child: Column(
        children: [
          30.hGap,
          AppText(
            text: "Sign Up",
            color: Colors.white,
            fontSize: 30.hWise,
          ),
          10.hGap,
          TextField(
            controller: viewModel.username,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
              hintText: 'Enter Username',
            ),
          ),
          10.hGap,
          TextField(
            controller: viewModel.email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Enter Email',
            ),
          ),
          10.hGap,
          TextField(
            controller: viewModel.password,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter Password',
            ),
          ),
          10.hGap,
          GestureDetector(
            onTap: viewModel.onPressedSignUp,
            child: Container(
              width: 40.hWise,
              height: 40.hWise,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.hWise),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_right_alt_sharp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
