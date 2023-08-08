import 'dart:convert';

import 'package:blog_frontend/models/blog_model.dart';
import 'package:blog_frontend/ui/components/button.dart';
import 'package:universal_html/html.dart';
import 'package:blog_frontend/file_exporter.dart';
import 'dart:html' as html;

part 'home_view_components.dart';
part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            if (!model.showOptions) ...[
              GestureDetector(
                  onTap: model.onPressedOptions,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  )).alignCR,
            ] else ...[
              GestureDetector(
                onTap: model.onPressedOptions,
                child: Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.white,
                  size: 40.hWise,
                ),
              ).alignCR,
            ],
            60.wGap,
          ],
        ),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    50.wGap,
                    if (model.showHome) ...[ViewHome()],
                    if (model.showAddPost) ...[AddPost()],
                    if (model.showMyPosts) ...[ViewMyPosts()],
                    20.wGap,
                    if (model.showOptions) ...[Options()],
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
