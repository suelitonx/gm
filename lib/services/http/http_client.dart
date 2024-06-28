import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url, Map<String, String>? headers});
  Future post({required String url, Map<String, String>? headers, Object? body});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url, Map<String, String>? headers}) async {
    return await client.get(Uri.parse(url), headers: headers);
  }

  @override
  Future post({required String url, Map<String, String>? headers, Object? body}) async {
    return await client.post(Uri.parse(url), headers: headers, body: body);
  }
}
