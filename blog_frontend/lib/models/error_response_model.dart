class ErrorResponseModel {
  int? errorCode;
  String? message;

  ErrorResponseModel({this.errorCode, this.message});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      errorCode: json['errorCode'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'message': message,
      };

  ErrorResponseModel copyWith({
    int? errorCode,
    String? message,
  }) {
    return ErrorResponseModel(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }
}
