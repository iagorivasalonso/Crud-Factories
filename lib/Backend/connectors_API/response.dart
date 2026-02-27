class ApiResponse {
  final bool ok;
  final String message;

  ApiResponse({required this.ok, required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(ok: json['ok'], message: json['message']);
  }
}
