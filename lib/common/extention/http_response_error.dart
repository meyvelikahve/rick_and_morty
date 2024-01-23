import 'package:http/http.dart';

extension HttpResponseError on Response {
  String httpResponseError() =>
      'Request Failed : Status Code $statusCode Reason : $reasonPhrase';
}
