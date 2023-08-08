class BlogModel {
  String? id;
  String? title;
  String? description;
  String? photo;
  String? username;

  BlogModel({this.id, this.title, this.description, this.photo, this.username});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json['title'] as String?,
      id: json['id'] as String?,
      description: json['desc'] as String?,
      photo: json['photo'] as String?,
      username: json['username'] as String?,
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'errorCode': errorCode,
  //       'message': message,
  //     };
}
