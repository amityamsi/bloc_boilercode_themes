class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.example.com/v1';
  static const String devBaseUrl = 'https://dev-api.example.com/v1';
  static const String stagingBaseUrl = 'https://staging-api.example.com/v1';
  static const String prodBaseUrl = 'https://api.example.com/v1';
  
  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  
  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';
  static const String uploadAvatar = '/user/avatar';
  
  // Common endpoints
  static const String upload = '/upload';
  static const String uploadMultiple = '/upload/multiple';
  static const String download = '/download';
  
  // HTTP Status Codes
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  
  // HTTP Methods
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
  
  // Content Types
  static const String applicationJson = 'application/json';
  static const String multipartFormData = 'multipart/form-data';
  static const String applicationXWwwFormUrlencoded = 'application/x-www-form-urlencoded';
  
  // Common Headers
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String userAgent = 'User-Agent';
  static const String cacheControl = 'Cache-Control';
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds
  
  // Pagination
  static const String page = 'page';
  static const String limit = 'limit';
  static const String sort = 'sort';
  static const String order = 'order';
  static const String search = 'search';
  
  // File upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  static const List<String> allowedVideoTypes = ['mp4', 'avi', 'mov', 'wmv'];
  static const List<String> allowedAudioTypes = ['mp3', 'wav', 'aac', 'ogg'];
  
  // Error Messages
  static const String networkError = 'Network error occurred';
  static const String timeoutError = 'Request timeout';
  static const String serverError = 'Server error occurred';
  static const String unauthorizedError = 'Unauthorized access';
  static const String forbiddenError = 'Access forbidden';
  static const String notFoundError = 'Resource not found';
  static const String validationError = 'Validation error';
  static const String unknownError = 'Unknown error occurred';
  
  // Success Messages
  static const String successMessage = 'Operation completed successfully';
  static const String createdMessage = 'Resource created successfully';
  static const String updatedMessage = 'Resource updated successfully';
  static const String deletedMessage = 'Resource deleted successfully';
  static const String uploadedMessage = 'File uploaded successfully';
  
  // API Response Keys
  static const String data = 'data';
  static const String message = 'message';
  static const String error = 'error';
  static const String status = 'status';
  static const String code = 'code';
  static const String token = 'token';
  static const String refreshToken = 'refresh_token';
  static const String expiresIn = 'expires_in';
  static const String user = 'user';
  static const String pagination = 'pagination';
  static const String total = 'total';
  static const String pageKey = 'page';
  static const String limitKey = 'limit';
  static const String hasNext = 'has_next';
  static const String hasPrev = 'has_prev';
  
  // Query Parameters
  static const String include = 'include';
  static const String fields = 'fields';
  static const String filter = 'filter';
  static const String expand = 'expand';
  static const String select = 'select';
  static const String exclude = 'exclude';
  
  // File Upload Parameters
  static const String file = 'file';
  static const String files = 'files';
  static const String fileName = 'filename';
  static const String fileType = 'file_type';
  static const String fileSize = 'file_size';
  static const String filePath = 'file_path';
  static const String fileUrl = 'file_url';
  
  // Authentication
  static const String bearer = 'Bearer';
  static const String basic = 'Basic';
  static const String apiKey = 'X-API-Key';
  static const String clientId = 'client_id';
  static const String clientSecret = 'client_secret';
  static const String grantType = 'grant_type';
  static const String username = 'username';
  static const String password = 'password';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String otp = 'otp';
  static const String codeParam = 'code';
  
  // Common Query Parameters
  static const String id = 'id';
  static const String name = 'name';
  static const String emailParam = 'email';
  static const String phoneParam = 'phone';
  static const String statusParam = 'status';
  static const String type = 'type';
  static const String category = 'category';
  static const String tag = 'tag';
  static const String date = 'date';
  static const String startDate = 'start_date';
  static const String endDate = 'end_date';
  static const String createdParam = 'created';
  static const String updated = 'updated';
  static const String deleted = 'deleted';
  static const String active = 'active';
  static const String inactive = 'inactive';
  static const String enabled = 'enabled';
  static const String disabled = 'disabled';
  static const String public = 'public';
  static const String private = 'private';
  static const String featured = 'featured';
  static const String popular = 'popular';
  static const String trending = 'trending';
  static const String latest = 'latest';
  static const String oldest = 'oldest';
  static const String ascending = 'asc';
  static const String descending = 'desc';
} 