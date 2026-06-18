

class ApiResponse {

  final bool ok;
  final String message;
  final dynamic data;

  ApiResponse({required this.ok, required this.message,required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    String msg;
    if (json['message'] != null && json['message'] is String) {
      msg = json['message'];
    } else if (json['error'] != null &&
        json['error'] is Map &&
        json['error']['message'] is String) {
      msg = json['error']['message'];
    } else {
      msg = 'Error desconocido';
    }

    return ApiResponse(
      ok: json['ok'] ?? false,
      message: msg,
      data: json['data']
    );
  }
}