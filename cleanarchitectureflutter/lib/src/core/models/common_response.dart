class CommonResponseModel {
  final bool isSuccess;
  final String message;
  final dynamic data;
  CommonResponseModel({
    required this.isSuccess,
    required this.message,
    this.data,
  });
}
