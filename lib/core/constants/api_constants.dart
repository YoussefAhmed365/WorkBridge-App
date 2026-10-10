class ApiConstants {
  // Base URL
  static const String baseUrl = "https://api.workbridge.eg/v1";

  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String jobs = '/jobs';
  static const String serviceRequests = '/service-requests';
  static const String contracts = '/contracts';
  static const String profile = '/profile';
}