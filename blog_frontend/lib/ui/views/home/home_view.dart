

import 'package:blog_frontend/file_exporter.dart';
part 'home_view_components.dart';
part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
              ],
            ),
          ),
        ),
      ),
    );
  }
}
