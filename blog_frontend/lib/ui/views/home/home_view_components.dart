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
            onTap: viewModel.onPressedHome,
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
        child: Container());
  }
}
