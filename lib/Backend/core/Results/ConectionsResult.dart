class ConnectionResult {
  final bool ok;
  final String message;

  ConnectionResult(this.ok, this.message);
}

class DisconnectResponse {
  final bool ok;
  final bool noActiveSession;
  final String? message;

  DisconnectResponse({
    required this.ok,
    this.noActiveSession = false,
    this.message,
  });
}
