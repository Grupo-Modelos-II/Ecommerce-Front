import 'package:http/http.dart' as http;
import 'package:ecommerce/private/environment_config.dart';
import 'package:ecommerce/util/logger.dart';

class HttpClient {
  late final String _baseUrl, _mainEndpoint;
  late final bool _isHttp;
  late Map<String, String> _headers;

  HttpClient() {
    this._baseUrl = EnvironmentConfig.apiUrl +
        (EnvironmentConfig.apiPort.isNotEmpty
            ? ':' + EnvironmentConfig.apiPort
            : '');
    this._mainEndpoint = EnvironmentConfig.apiEndpoint;
    this._isHttp = !EnvironmentConfig.isSecure;
    this._headers = {
      'Content-Type': 'application/json',
    };
  }

  void addHeader(String key, String value) {
    this._headers[key] = value;
  }

  void removeHeader(String key) {
    this._headers.remove(key);
  }

  dynamic get headers => this._headers;

  Uri _getTypeRequest(String endPoint, {dynamic? queryParams}) {
    Uri uri;
    if (this._isHttp) {
      uri = Uri.http(this._baseUrl, this._mainEndpoint + endPoint, queryParams);
    } else {
      uri =
          Uri.https(this._baseUrl, this._mainEndpoint + endPoint, queryParams);
    }
    LoggerUtil.logger.v("Ruta de envio: $uri");
    LoggerUtil.logger.wtf(this._headers);
    return uri;
  }

  Future<http.Response> get(String endPoint,
      {Map<String, Object>? queryParams}) async {
    LoggerUtil.logger.d("Sending GET request");
    var url = this._getTypeRequest(endPoint, queryParams: queryParams);
    var response = await http.get(url, headers: this._headers);
    LoggerUtil.logger.d(response.body);
    return response;
  }

  Future<http.Response> post(String endPoint,
      {dynamic body, Map<String, Object>? queryParams}) async {
    LoggerUtil.logger.d("Sending POST request");
    var url = this._getTypeRequest(endPoint, queryParams: queryParams);
    var response = await http.post(url, headers: this._headers, body: body);
    LoggerUtil.logger.d(response.body);
    return response;
  }

  Future<http.Response> put(String endPoint,
      {Map<String, String>? body, Map<String, Object>? queryParams}) async {
    LoggerUtil.logger.d("Sending PUT request");
    var url = this._getTypeRequest(endPoint, queryParams: queryParams);
    var response = await http.put(url, body: body);
    LoggerUtil.logger.d(response.body);
    return response;
  }

  Future<http.Response> delete(String endPoint,
      {Map<String, Object>? queryParams}) async {
    LoggerUtil.logger.d("Sending DELETE request");
    var url = this._getTypeRequest(endPoint, queryParams: queryParams);
    var response = await http.delete(url);
    LoggerUtil.logger.d(response.body);
    return response;
  }
}
