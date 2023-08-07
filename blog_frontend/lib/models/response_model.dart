class ResponseModel {
  bool success;
  int? statusCode;
  String? message;
  List<dynamic>? data;
  List<dynamic>? result;
  String? next;
  String? prev;
  int? count;

  ResponseModel(
      {required this.success,
      this.statusCode,
      this.message,
      this.data,
      this.result,
      this.next,
      this.prev,
      this.count});

  bool get hasData => success && data != null && data!.isNotEmpty;

  Map<String, dynamic> get getData => hasData ? data![0] : null;

  bool get hasResult => success && result != null && result!.isNotEmpty;

  Map<String, dynamic> get getResult => hasResult ? result![0] : null;
}
