import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/location/data/api/ilocation_api_service.dart';

final locationApiServiceProvider = Provider<ILocationApiService>((ref) {
  return LocationApiService();
});

class LocationApiService with UrlMixin implements ILocationApiService {
  @override
  Future<http.Response> getLocationResponse() async {
    try {
      Uri url = getUriWithPath('/api/location');

      var response = await http.get(url);
      return response;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
