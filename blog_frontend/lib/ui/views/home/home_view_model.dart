part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool showOptions = false;
  bool showHome = true;
  bool showMyPosts = false;
  bool showAddPost = false;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String? imageDataUrl;
  List<BlogModel> posts = [];
  final log = getLogger("HomeViewModel");
  String username = "";
  init() {
    username = window.localStorage['username']!;
    getPosts();
  }

  void onPressedMyPosts() {
    showHome = false;
    showMyPosts = true;
    showAddPost = false;
    notifyListeners();
  }

  void onPressedLogout() {
    window.localStorage.remove('id');
    window.localStorage.remove('username');
    navigationService.clearStackAndShow(Routes.splashView);
  }

  void onPressedOptions() {
    showOptions = !showOptions;
    notifyListeners();
  }

  void onAddPost() {
    showHome = false;
    showMyPosts = false;
    showAddPost = true;
    notifyListeners();
  }

  void onAccountDetails() {}

  void onPressedHome() {
    showHome = true;
    showMyPosts = false;
    showAddPost = false;
    notifyListeners();
  }

  void _pickImage() {
    final FileUploadInputElement input = html.FileUploadInputElement();
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        if (reader.result != null) {
          imageDataUrl = reader.result as String;
          notifyListeners();
          // You can now use the 'imageDataUrl' to display the selected image.
          // For example, you can use the Image.memory widget to display it:
          // Image.memory(base64Decode(imageDataUrl.split(",").last));
        }
      });
    });
  }

  Uint8List _dataUriToBytes(String dataUri) {
    final bytes = base64.decode(dataUri.split(',').last);
    return Uint8List.fromList(bytes);
  }

  createPost() async {
    final response = imageDataUrl.isNullOrEmpty
        ? await ApiService.instance.createPost(
            title: title.text,
            username: window.localStorage["username"]!,
            description: description.text)
        : await ApiService.instance.createPost(
            title: title.text,
            username: window.localStorage["username"]!,
            description: description.text,
            image: imageDataUrl);
    response.fold(
      (l) => {
        Fluttertoast.showToast(
            msg: l.message.isNotNull ? l.message! : "maybe sane title exists"),
      },
      (r) => {
        log.i(r),
        Fluttertoast.showToast(msg: "Created"),
        navigationService.clearStackAndShow(Routes.homeView),
      },
    );
  }

  getPosts() async {
    final response = await ApiService.instance.getPosts();
    response.fold(
      (l) => {
        Fluttertoast.showToast(msg: l.message.isNotNull ? l.message! : "error"),
      },
      (r) =>
          {posts = r, log.i('total posts: ${posts.length}'), notifyListeners()},
    );
  }
}
