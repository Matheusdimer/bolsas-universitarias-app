class ErrorResponse {
  late int status;
  late String message;

  ErrorResponse(this.status, this.message);

  ErrorResponse.fromJson(final dynamic json) {
    status = json['status'];
    message = json['message'];
  }
}