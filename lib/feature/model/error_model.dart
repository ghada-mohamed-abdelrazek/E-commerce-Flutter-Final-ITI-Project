class ErrorModel {
  final String msg;
  final int status;

  ErrorModel({required this.msg, required this.status});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(msg: json['Response Text'], status: json['statusCode']);
  }
}