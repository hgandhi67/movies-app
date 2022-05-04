import 'package:http/http.dart' as http;
import 'package:movies_app/api/api_endpoints.dart';
import 'package:movies_app/api/exceptions.dart';

/// [ApiProvider] is the base api provider class which will call all the rest api.
/// This class contains [http.get], [http.put], [http.patch], [http.post] and the post api with the [http.MultipartFile]
/// as a part of the it.
class ApiProvider {
  static http.Client client = http.Client();
  static Map<String, String> headers = {};
  static String baseUrl = ApiEndpoints.baseUrlProd;

  /// GET Api : Takes in the url endpoint and headers, update the headers and call the [http.get] rest api call.
  static Future<dynamic> getAsync(String urlEndpoint, {Map<String, String>? headersNew}) async {
    var responseData;
    if (headersNew != null) headers.addAll(headersNew);
    try {
      print("The url -> ${baseUrl + urlEndpoint}");
      print("The headers -> $headers");
      final response = await client.get(Uri.parse(urlEndpoint.startsWith('http') ? urlEndpoint : baseUrl + urlEndpoint),
          headers: headers);
      print("The response -> ${response.body.toString()}");
      responseData = _response(response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }

    return responseData;
  }

  /// POST Api : Takes in the url endpoint, body and headers, update the headers and call the [http.post] rest api call.
  static Future<dynamic> postAsync(String urlEndpoint, {Map<String, String>? headersNew, dynamic body}) async {
    var responseData;
    if (headersNew != null) headers.addAll(headersNew);
    try {
      print("The url -> ${baseUrl + urlEndpoint}");
      print("The body --> $body");
      final response = await client.post(
          Uri.parse(urlEndpoint.startsWith('http') ? urlEndpoint : baseUrl + urlEndpoint),
          body: body,
          headers: headers);
      print("The response -> ${response.body.toString()}");
      responseData = _response(response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }

    return responseData;
  }

  /// PUT Api : Takes in the url endpoint, body and headers, update the headers and call the [http.put] rest api call.
  static Future<dynamic> putAsync(String urlEndpoint, {Map<String, String>? headersNew, dynamic body}) async {
    var responseData;
    if (headersNew != null) headers.addAll(headersNew);

    try {
      final response = await client.put(Uri.parse(urlEndpoint.startsWith('http') ? urlEndpoint : baseUrl + urlEndpoint),
          body: body, headers: headers);
      responseData = _response(response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }

    return responseData;
  }

  /// PATCH Api : Takes in the url endpoint, body and headers, update the headers and call the [http.patch] rest api call.
  static Future<dynamic> patchAsync(String urlEndpoint, {Map<String, String>? headersNew, dynamic body}) async {
    var responseData;
    if (headersNew != null) headers.addAll(headersNew);

    try {
      final response = await client.patch(
          Uri.parse(urlEndpoint.startsWith('http') ? urlEndpoint : baseUrl + urlEndpoint),
          body: body,
          headers: headers);
      responseData = _response(response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }

    return responseData;
  }

  /// DELETE Api : Takes in the url endpoint, body and headers, update the headers and call the [http.delete] rest api call.
  static Future<dynamic> deleteAsync(String urlEndpoint, {Map<String, String>? headersNew}) async {
    var responseData;
    if (headersNew != null) headers.addAll(headersNew);

    try {
      final response = await client
          .delete(Uri.parse(urlEndpoint.startsWith('http') ? urlEndpoint : baseUrl + urlEndpoint), headers: headers);
      responseData = _response(response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }

    return responseData;
  }

  /// Function which will take the response as input and will return the proper output.
  /// It matches the status code of the response and based on that will either provide the response back
  /// or else exceptions.
  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response;
        return responseJson;
      case 201:
        var responseJson = response;
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
