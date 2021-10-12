import 'package:ecommerce/util/http_client.dart';
import 'package:ecommerce/util/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' show json;

class AuthHandler {
  HttpClient authClient = HttpClient();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> login(String name, String password) async {
    LoggerUtil.logger.v("Iniciando Servicio de Autenticación");
    final SharedPreferences prefs = await _prefs;
    Map<String, String> bodyData = {'email': name, 'password': password};
    var response =
        await authClient.post('/auth/login', body: json.encode(bodyData));
    var bodyResponse = json.decode(response.body);

    LoggerUtil.logger.v("Respuesta del servidor: $bodyResponse");

    if (bodyResponse['token'] != null) {
      await prefs.setString('token', bodyResponse['token']);
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token') ?? '';
  }

  Future<Map<String, dynamic>> getTokenClaims() async {
    return JwtDecoder.decode(await getToken());
  }
}
