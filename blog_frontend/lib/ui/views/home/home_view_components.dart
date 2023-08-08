part of 'home_view.dart';

class Options extends ViewModelWidget<HomeViewModel> {
  const Options({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
      width: 300.wWise,
      height: 700.hWise,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 45, 26, 129),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          50.hGap,
          GestureDetector(
            onTap: viewModel.onPressedHome,
            child: AppText(
              text: "Home",
              fontSize: 20.hWise,
            ).alignTC,
          ).alignCR,
          20.hGap,
          GestureDetector(
            onTap: viewModel.onPressedMyPosts,
            child: AppText(
              text: "My Posts",
              fontSize: 20.hWise,
            ).alignTC,
          ).alignCR,
          20.hGap,
          GestureDetector(
            onTap: viewModel.onAddPost,
            child: AppText(
              text: "Add Post",
              fontSize: 20.hWise,
            ).alignTC,
          ).alignCR,
          20.hGap,
          GestureDetector(
            onTap: viewModel.onAccountDetails,
            child: AppText(
              text: "Account Details",
              fontSize: 20.hWise,
            ).alignTC,
          ).alignCR,
          20.hGap,
          GestureDetector(
            onTap: viewModel.onPressedLogout,
            child: AppText(
              text: "Log Out",
              fontSize: 20.hWise,
            ).alignTC,
          ).alignCR,
        ],
      ),
    );
  }
}

class AddPost extends ViewModelWidget<HomeViewModel> {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(50),
      width:
          context.w - (viewModel.showOptions ? 1 : 0) * (300.wWise) - 100.wWise,
      height: 700.hWise,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 45, 26, 129),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AppText(
            text: "Add Blog",
            fontSize: 30.hWise,
            color: Colors.white,
          ),
          20.hGap,
          TextField(
            onChanged: (value) => {viewModel.notifyListeners()},
            style: TextStyle(fontSize: 20.hWise),
            controller: viewModel.title,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
              hintText: 'Enter Title',
              focusColor: Colors.white,
            ),
          ),
          20.hGap,
          Row(
            children: [
              Container(
                width: context.w -
                    (viewModel.showOptions ? 1 : 0) * (300.wWise) -
                    200.wWise -
                    (viewModel.imageDataUrl.isNotNull ? 1 : 0) * (300.wWise),
                child: TextField(
                  onChanged: (value) => {viewModel.notifyListeners()},
                  style: TextStyle(fontSize: 20.hWise),
                  controller: viewModel.description,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                  ),
                ),
              ),
              if (viewModel.imageDataUrl.isNotNull) ...[
                20.wGap,
                Container(
                  width: 280.wWise,
                  height: 280.hWise,
                  child: Image.memory(
                      viewModel._dataUriToBytes(viewModel.imageDataUrl!)),
                ),
              ],
            ],
          ),
          20.hGap,
          if (viewModel.imageDataUrl.isNotNull) ...[
            Icon(
              Icons.check_box,
              color: Colors.white,
              size: 60.hWise,
            ),
          ] else ...[
            GestureDetector(
              onTap: viewModel._pickImage,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 60.hWise,
              ),
            ),
          ],
          20.hGap,
          if (viewModel.title.text.isNotEmpty &&
              viewModel.description.text.isNotEmpty) ...[
            GestureDetector(
              onTap: viewModel.createPost,
              child: Container(
                width: 60.hWise,
                height: 60.hWise,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.hWise),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.black,
                  size: 40.hWise,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class ViewHome extends ViewModelWidget<HomeViewModel> {
  const ViewHome({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
        padding: EdgeInsets.all(50),
        width: context.w -
            (viewModel.showOptions ? 1 : 0) * (300.wWise) -
            100.wWise,
        height: 700.hWise,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 45, 26, 129),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 600.hWise,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 4,
                childAspectRatio: 1,
                children: [
                  for (int i = 0; i < viewModel.posts.length; i++)
                    Padding(
                      padding: EdgeInsets.all(8.hWise),
                      child: BlogCard(
                        index: i,
                      ),
                    )
                ],
              ),
            )
          ],
        ));
  }
}

class BlogCard extends ViewModelWidget<HomeViewModel> {
  final int index;
  const BlogCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return GestureDetector(
      onTap: () => _showDescriptionDialog(context, viewModel),
      child: Container(
        width: 250.wWise,
        height: 250.hWise,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            AppText(
              text: viewModel.posts[index].title!,
              fontSize: 20.hWise,
              color: Colors.white,
            ),
            if (!viewModel.posts[index].photo.isNullOrEmpty) ...[
              Image.memory(
                viewModel._dataUriToBytes(viewModel.posts[index].photo!),
              ),
            ] else ...[
              Expanded(
                child: Image.asset("assets/img/splash.png"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDescriptionDialog(BuildContext context, HomeViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(viewModel.posts[index].title!),
        content: Text(viewModel.posts[index].description!),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class ViewMyPosts extends ViewModelWidget<HomeViewModel> {
  const ViewMyPosts({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
        padding: EdgeInsets.all(50),
        width: context.w -
            (viewModel.showOptions ? 1 : 0) * (300.wWise) -
            100.wWise,
        height: 700.hWise,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 45, 26, 129),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 600.hWise,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 4,
                childAspectRatio: 1,
                children: [
                  for (int i = 0; i < viewModel.posts.length; i++)
                    if (viewModel.username == viewModel.posts[i].username) ...[
                      Padding(
                        padding: EdgeInsets.all(8.hWise),
                        child: BlogCard(
                          index: i,
                        ),
                      )
                    ]
                ],
              ),
            )
          ],
        ));
  }
}
