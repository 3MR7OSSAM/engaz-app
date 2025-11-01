abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  });
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  });
  Future<dynamic> delete(String path, {Map<String, dynamic>? headers});
  Future<dynamic> postWithFile(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, String>? filePaths,
    Map<String, dynamic>? headers,
  });
  Future<dynamic> putWithFile(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, String>? filePaths,
    Map<String, dynamic>? headers,
  });
}
