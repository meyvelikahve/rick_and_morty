import 'package:http/http.dart' as http;

abstract class ILocationApiService {
  Future<http.Response> getLocationResponse();
}